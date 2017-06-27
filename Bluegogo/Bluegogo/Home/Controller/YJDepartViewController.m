//
//  YJDepartViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/26.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJDepartViewController.h"
#import "YJDepartCell.h"
#import "YJNavController.h"
#import "YJDateController.h"
@interface YJDepartViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,DepartCellDelegate>
{
	CGRect listFrame;
	CGRect listFullFrame;
	BOOL showMap;
}
@property(nonatomic,strong)UITableView *listTable;
@property(nonatomic,strong)AMapSearchAPI *searchApi;
@property(nonatomic,strong)AMapPOISearchResponse *response;
@property(nonatomic,strong) UIView *loadingView;
@end

@implementation YJDepartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
	[self loadData];
}
-(void)viewWillAppear:(BOOL)animated
{
	self.title = self.titleStr;
	if (!showMap) {
		self.navigationController.navigationBar.hidden = NO;
	}
	else
	{
		self.navigationController.navigationBar.hidden = NO;
	}
}
-(void)loadData
{
	AMapPOIAroundSearchRequest *requst = [[AMapPOIAroundSearchRequest alloc] init];
	requst.location = [AMapGeoPoint locationWithLatitude:self.location.latitude longitude:self.location.longitude];
	requst.keywords = self.titleStr;
	requst.sortrule = 0;
	requst.requireExtension = YES;
	[self.searchApi AMapPOIAroundSearch:requst];
}
-(void)initUI
{
	showMap = NO;
	self.view.backgroundColor = COLOR(245, 245, 245);
	[self initloadingView];
	
	self.searchApi = [[AMapSearchAPI alloc] init];
	self.searchApi.delegate = self;
	
	[AMapServices sharedServices].enableHTTPS = YES;
	MAMapView *mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 300)];
	mapView.showsScale = YES;
	mapView.showsCompass = YES;
	mapView.logoCenter = CGPointMake(SCREENWIDTH-50, 285);
	mapView.zoomLevel = 16;
	mapView.minZoomLevel = 14;
	mapView.maxZoomLevel = 17;
	
	[self.view insertSubview:mapView atIndex:0];
	mapView.showsUserLocation = YES;
	mapView.userTrackingMode = MAUserTrackingModeFollow;
	
	UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 30, 30, 30)];
	backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30.0];
	[backBtn setTitle:@"\U0000e604" forState:UIControlStateNormal];
	backBtn.titleLabel.textColor = [UIColor whiteColor];
	backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
	backBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
	backBtn.layer.cornerRadius = 15;
	backBtn.layer.masksToBounds = YES;
	[backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
	[self.view insertSubview:backBtn aboveSubview:mapView];
	
	UITableView *list = [[UITableView alloc] init];
	list.delegate = self;
	list.dataSource = self;
	list.dataSource = self;
	list.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view insertSubview:list atIndex:1];
	[list registerClass:[YJDepartCell class] forCellReuseIdentifier:@"DepartCell"];
	self.listTable = list;
}
-(void)initloadingView
{
	UIView *loading = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
	loading.backgroundColor = COLOR(245, 245, 245);
	UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 30, 30, 30)];
	backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30.0];
	[backBtn setTitle:@"\U0000e604" forState:UIControlStateNormal];
	backBtn.titleLabel.textColor = [UIColor whiteColor];
	backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
	backBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
	backBtn.layer.cornerRadius = 15;
	backBtn.layer.masksToBounds = YES;
	[loading addSubview:backBtn];
	[backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
	
	UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2 - 50, 200, 100, 100)];
	[logo setImage:[UIImage imageNamed:@"logo"]];
	[loading addSubview:logo];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.fromValue = [NSNumber numberWithFloat:1.0f];
	animation.toValue = [NSNumber numberWithFloat:0.0f];
	animation.autoreverses = YES;
	animation.duration = 0.5f;
	animation.repeatCount = MAXFLOAT;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[logo.layer addAnimation:animation forKey:@"aAlpha"];
	
	UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, SCREENWIDTH, 20)];
	tips.textColor = NAVBLUECOLOR;
	tips.text = @"加载中";
	tips.textAlignment = NSTextAlignmentCenter;
	tips.font = [UIFont systemFontOfSize:20.0f];
	[loading addSubview:tips];
	self.loadingView = loading;
	[self.view addSubview:self.loadingView];
}
-(void)backClick
{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.response.pois.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJDepartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DepartCell"];
	cell.delegate = self;
	cell.name.text = self.response.pois[indexPath.row].name;
	cell.location.text = self.response.pois[indexPath.row].address;
	if (self.canDate) {
		[cell.contentView addSubview:cell.datingBtn];
	}else
	{
		[cell.datingBtn removeFromSuperview];
	}
	CGFloat distance = self.response.pois[indexPath.row].distance;
	if (distance/1000 >= 1) {
		cell.distance.text = [NSString stringWithFormat:@"%0.1f公里",distance/1000];
	}else
	{
		cell.distance.text = [NSString stringWithFormat:@"%d米",(int)distance];
	}
	cell.tel = self.response.pois[indexPath.row].tel;
	cell.index = indexPath.row;
	return cell;
}

//判断手势改变tableview frame
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
	if (translation.y > 0) {
		{
			NSIndexPath *dic = self.listTable.indexPathsForVisibleRows.firstObject;
			if (self.listTable.frame.origin.y == 64 && dic.row == 0) {
    [UIView animateWithDuration:0.2 animations:^{
		showMap = YES;
		self.navigationController.navigationBar.hidden = NO;
		self.listTable.frame = listFrame;
	}];
			}
		}
	}else if (translation.y < 0){
		if (self.listTable.frame.origin.y == 300) {
			[UIView animateWithDuration:0.2 animations:^{
				showMap = NO;
				self.navigationController.navigationBar.hidden = false;
				self.listTable.frame = listFullFrame;
			}];
		}
		
	}
}


#pragma  mark -- 搜索回调
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
	if (response.pois.count == 0) {
		return;
	}
	self.response = response;
	listFrame = CGRectMake(0, 300, SCREENWIDTH, 100 * response.pois.count >= SCREENHEIGHT -  300 ? SCREENHEIGHT - 300  : 100 * response.pois.count);
	listFullFrame = CGRectMake(0, 64, SCREENWIDTH, 100 * response.pois.count >= SCREENHEIGHT-64 ? SCREENHEIGHT-64 : 100 * response.pois.count);
	
	self.listTable.frame = listFrame;
	[self.listTable reloadData];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.loadingView removeFromSuperview];
	});
}

#pragma mark Cell Delegate
-(void)callNumber:(NSString *)tel
{
	if ([tel isEqualToString:@""]) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抱歉，该商户无电话" message:nil preferredStyle:UIAlertControllerStyleAlert];
		[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			[alert dismissViewControllerAnimated:YES completion:nil];
		}]];
		[self presentViewController:alert animated:YES completion:nil];
	}else
	{
		NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
		UIWebView *webView = [UIWebView new];
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
		[self.view addSubview:webView];
	}
}

-(void)naviForIndex:(NSUInteger)index
{
	YJNavController *navVC = [YJNavController new];
	navVC.starPoint = [AMapNaviPoint locationWithLatitude:self.location.latitude longitude:self.location.longitude];
	navVC.endPoint = [AMapNaviPoint locationWithLatitude:self.response.pois[index].location.latitude longitude:self.response.pois[index].location.longitude];
	[self.navigationController pushViewController:navVC animated:YES];
}
-(void)date
{
	YJDateController *dateVC = [YJDateController new];
	NSMutableDictionary *tempDic = [NSMutableDictionary new];
	[tempDic setObject:self.titleStr forKey:@"headStr"];
	[tempDic setObject:self.response.pois[0].name forKey:@"name"];
	[tempDic setObject:self.response.pois[0].address forKey:@"address"];
	[tempDic setObject:self.response.pois[0].uid forKey:@"uid"];
	dateVC.dicData = tempDic;
	[self.navigationController pushViewController:dateVC animated:YES];
}
@end
