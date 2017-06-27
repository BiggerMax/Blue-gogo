//
//  YJNavController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/27.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJNavController.h"

@interface YJNavController ()<AMapNaviDriveManagerDelegate,MAMapViewDelegate,AMapNaviDriveViewDelegate>
@property(nonatomic,strong)AMapNaviDriveView *driveView;
@property(nonatomic,strong)AMapNaviDriveManager *driveManager;
@end

@implementation YJNavController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initProperty];
	[self calculateRoutes];
}
-(void)initProperty
{
	if (self.driveManager == nil) {
		self.driveManager = [AMapNaviDriveManager new];
		self.driveManager.delegate = self;
	}
	if (self.driveView == nil) {
		AMapNaviDriveView *driveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, SCREENHEIGHT - 20)];
		driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		[driveView setDelegate:self];
		[self.view addSubview:driveView];
		self.driveView = driveView;
		
		[self.driveManager addDataRepresentative:self.driveView];
	}
}
-(void)calculateRoutes
{
	[self.driveManager calculateDriveRouteWithStartPoints:@[self.starPoint] endPoints:@[self.endPoint] wayPoints:nil drivingStrategy:17];
}
-(void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
	[self.driveManager startGPSNavi];
}

#pragma mark -- DriveView Delegate
-(void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView
{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否退出导航?" message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		[alert dismissViewControllerAnimated:YES completion:nil];
	}]];
	[alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[alert dismissViewControllerAnimated:YES completion:nil];
		[self.navigationController popViewControllerAnimated:YES];
	}]];
	[self presentViewController:alert animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = YES;
	UIColor *color = COLOR(40, 44, 45);
	[self setStatusBarBackgroundColor:color];
}
-(void)viewWillDisappear:(BOOL)animated
{
	[self setStatusBarBackgroundColor:nil];
}
-(void)setStatusBarBackgroundColor:(UIColor *)color
{
	UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
	if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
		statusBar.backgroundColor = color;
	}
}
@end
