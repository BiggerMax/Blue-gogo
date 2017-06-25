//
//  YJHomeViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJCollectionViewCell.h"
#import "YJHomeTopView.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface YJHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HomeTopViewDelegate,CLLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic, strong) NSArray *collectionItems;
@property(nonatomic,copy) NSString *locationStr;
@property(nonatomic,strong) AMapReGeocode *geoCode;
@property(nonatomic,strong) CLLocationManager *locManager;
@property(nonatomic,assign) CLLocationCoordinate2D coorDinate;
@property(nonatomic,strong)AMapSearchAPI *searchApi;
@property(nonatomic, strong) NSString *weatherKey;
@property(nonatomic, strong) NSMutableDictionary *weatherDic;
@property(nonatomic, assign) NSUInteger ordersCount;
@end

@implementation YJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self initProperty];
	[self loadData];
	[self initUI];
}
-(void)loadData
{
	NSArray *menuArray = @[@{@"name": @"加油站", @"image": @"\U0000e64b", @"color": [UIColor redColor], @"bgcolor": COLOR(151, 225, 138)}, @{@"name": @"紧急呼救", @"image": @"\U0000e61b", @"color": [UIColor redColor], @"bgcolor": COLOR(242, 176, 163)}, @{@"name": @"停车场", @"image": @"\U0000e608", @"color": COLOR(255, 233, 35), @"bgcolor": COLOR(108, 209, 253)}, @{@"name": @"养护爱车", @"image": @"\U0000e875", @"color": COLOR(231, 226, 47), @"bgcolor": NAVBLUECOLOR}, @{@"name": @"汽车维修", @"image": @"\U0000e6a5", @"color": COLOR(108, 209, 253), @"bgcolor": COLOR(242, 176, 163)}, @{@"name": @"汽车销售", @"image": @"\U0000e613", @"color": [UIColor yellowColor], @"bgcolor": COLOR(151, 225, 138)}];
	self.collectionItems = menuArray;
	
}
-(void)initUI
{
	self.view.backgroundColor = [UIColor whiteColor];
	YJHomeTopView *topView = [[YJHomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
	topView.delegate = self;
	[self.view addSubview:topView];
	
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(SCREENWIDTH / 2 - 0.5, (SCREENHEIGHT - 150) /3 -1
									 );
	flowLayout.sectionInset = UIEdgeInsetsZero;
	flowLayout.minimumInteritemSpacing = 1.0f;
	flowLayout.minimumLineSpacing = 1.0f;
	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT-150) collectionViewLayout:flowLayout];
	collectionView.backgroundColor = COLOR(245, 245, 245);
	collectionView.delegate = self;
	collectionView.dataSource = self;
	[collectionView registerClass:[YJCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
	[self.view addSubview:collectionView];
}
-(void)initProperty
{
	self.searchApi = [AMapSearchAPI new]
	;
	self.searchApi.delegate = self;
	self.locManager = [CLLocationManager new];
	self.locManager.delegate = self;
	self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAddress) name:@"changeAddress" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postAddPlace) name:@"postAddPlace" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrders) name:@"addOrderStates" object:nil];
	self.weatherKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"weather_key"];
}
- (void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = YES;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [_collectionItems count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	cell.itemName.text = self.collectionItems[indexPath.item][@"name"];
	cell.itemIcon.text = self.collectionItems[indexPath.item][@"image"];
	cell.itemIcon.textColor = self.collectionItems[indexPath.item][@"color"];
	cell.itemIcon.backgroundColor = self.collectionItems[indexPath.item][@"bgcolor"];
	return cell;

}
- (void)changeAddress
{
	NSLog(@"地址已经改变");
	self.locationStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
}

@end
