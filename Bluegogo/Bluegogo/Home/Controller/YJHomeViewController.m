//
//  YJHomeViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJCollectionViewCell.h"
#import "YJLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface YJHomeViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
HomeTopViewDelegate,
CLLocationManagerDelegate,
AMapSearchDelegate,
LocationViewDelegate
>

@property (nonatomic, strong) NSArray *collectionItems;
@property(nonatomic,strong) NSString *locationStr;
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
	[self locate];
	[self checkOrders];
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
	self.topView = topView;
	
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.item == 1) {
		NSMutableString *mulString = [[NSMutableString alloc] initWithFormat:@"tel:110"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mulString]];
	}
}
/**************************/
- (void)changeAddress
{
	NSLog(@"地址已经改变");
	self.locationStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
}
-(void)postAddPlace
{
	NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
	if (user_id && self.locationStr && ![self.locationStr isEqualToString:@""]) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSString *latitude = [NSString stringWithFormat:@"%f",self.coorDinate.latitude];
			NSString *longtitude = [NSString stringWithFormat:@"%f",self.coorDinate.longitude];
			NSDictionary *parameters = @{@"if": @"AddPlace",@"user_id":user_id, @"latitude": latitude, @"longitude": longtitude, @"place_name": self.locationStr, @"place_address": self.geoCode.formattedAddress};
			AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
			[manager POST:SERVER_ADDRESS parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
				
			} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				NSNumber *number = [responseObject objectForKey:@"code"];
				if (number.integerValue == 1) {
					NSLog(@"地理位置添加成功");
				}
			} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				NSLog(@"地理位置添加失败");
			}];
		});
	}else
	{
		NSLog(@"地理位置添加失败");
	}
}

-(void)addOrders
{
	NSMutableArray *orders = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderStates"];
	if (orders.count >= self.ordersCount) {
		self.ordersCount = orders.count;
		dispatch_async(dispatch_get_main_queue(), ^{
			self.topView.notisNum.hidden = NO;
			self.topView.notisNum.text = [NSString stringWithFormat:@"%lu",self.ordersCount];
		});
	}
	else{
		if (orders.count == 0) {
			dispatch_async(dispatch_get_main_queue(), ^{
				self.topView.notisNum.hidden = YES;
			});
		}
	}
}
-(void)checkOrders
{
	NSMutableArray *orders = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderStates"];
	self.ordersCount = orders.count;
	if (self.ordersCount == 0) {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.topView.notisNum.hidden = YES;
		});
	}else
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			self.topView.notisNum.hidden = NO;
			self.topView.notisNum.text = [NSString stringWithFormat:@"%lu", self.ordersCount];
		});
	}
}
-(void)locate
{
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			if (TARGET_IPHONE_SIMULATOR) {
				CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.958186, 116.306107);
				AMapCoordinateType type = AMapCoordinateTypeGPS;
				_coorDinate = AMapCoordinateConvert(CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude), type);
				[self reverseGeoCode];

			}
		else{
			if([self.locManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
				[self.locManager requestWhenInUseAuthorization];
			}
			[self.locManager startUpdatingLocation];
		});
}

#pragma mark --Location delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
	CLLocation *location = [locations lastObject];
	CLLocationCoordinate2D coordination = location.coordinate;
	NSLog(@"纬度:%f 经度:%f", coordination.latitude, coordination.longitude);
	[self reverseGeoCode];
	
	AMapCoordinateType type = AMapCoordinateTypeGPS;
	_coorDinate = AMapCoordinateConvert(CLLocationCoordinate2DMake(coordination.latitude, coordination.longitude), type);
	[manager stopUpdatingLocation];
}
-(void)reverseGeoCode
{
	AMapReGeocodeSearchRequest *requst = [AMapReGeocodeSearchRequest new];
	requst.location = [AMapGeoPoint locationWithLatitude:self.coorDinate.latitude longitude:self.coorDinate.longitude];
	requst.requireExtension = YES;
	[self.searchApi AMapReGoecodeSearch:requst];
}
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
	if (response.regeocode != nil) {
		self.geoCode = response.regeocode;
		[self updateWeather];
		
		NSString *neighbor = self.geoCode.addressComponent.neighborhood;
		NSString *building = self.geoCode.addressComponent.building;
		NSString *address = [NSString stringWithFormat:@"%@%@",neighbor,building];
		self.locationStr= address;
		if ([address isEqualToString:@""]) {
			self.locationStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
		}else
		{
			[[NSUserDefaults standardUserDefaults] setObject:address forKey:@"address"];
		}
		[self postAddPlace];
	}
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", error);
}

#pragma mark LocationView Delegate

-(void)reLocate
{
	[self locate];
}

#pragma  mark TopView Delegate
-(void)reLocateBtnClick
{
	YJLocationViewController *locatioView = [[YJLocationViewController alloc] init];
	locatioView.delegate = self;
	NSString *city = self.geoCode.addressComponent.city;
	NSString *district = self.geoCode.addressComponent.district;
	NSString *neighbor = self.geoCode.addressComponent.neighborhood;
	NSString *building = self.geoCode.addressComponent.building;
	NSString *address = [NSString stringWithFormat:@"%@%@%@%@",city,district,neighbor,building];
	locatioView.locationStr = address;
	
	NSMutableArray *poitArray = [NSMutableArray new];
	for (int i = 0; i < 3; i++) {
		if ([self.geoCode.pois count] > i) {
			NSString *pointString = self.geoCode.pois[i].name;
			[poitArray addObject:pointString];
		}
	}
	locatioView.pois = poitArray;
	[self presentViewController:locatioView animated:YES completion:nil];
}
-(void)updateWeather
{
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSString *url = @"https://free-api.heweather.com/v5/now";
		NSString *city = self.geoCode.addressComponent.city;
		NSDictionary *parameters = @{@"city": city, @"key": self.weatherKey};
		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		[manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
			
		} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			NSLog(@"这里打印请求成功要做的事");
			NSLog(@"%@",responseObject);
			NSMutableArray *HeWeather = [responseObject objectForKey:@"HeWeather5"];
			NSMutableDictionary *object = [HeWeather objectAtIndex:0];
			NSMutableDictionary *now = [object objectForKey:@"now"];
			NSMutableDictionary *con = [now objectForKey:@"cond"];
			NSString *weatherStr = [con objectForKey:@"txt"];
			
			NSString *tmpStr = [now objectForKey:@"tmp"];
			
			NSLog(@"weather: %@,,, tmp: %@", weatherStr, tmpStr);
			dispatch_async(dispatch_get_main_queue(), ^{
				self.topView.weatherLabel.text = weatherStr;
				self.topView.temperatureLabel.text = [NSString stringWithFormat:@"%@°", tmpStr];
			});

		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			NSLog(@"%@",error);
		}];
	});
}
-(void)weatherInfo
{
	NSLog(@"!!");
}
#pragma mark Setter
-(void)setLocationStr:(NSString *)locationStr
{
	_locationStr = locationStr;
	dispatch_async(dispatch_get_main_queue(), ^{
		self.topView.locationLabel.text = _locationStr;
	});
}
@end
