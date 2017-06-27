//
//  YJDateController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/27.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJDateController.h"

@interface YJDateController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) NSDictionary *iconData;
@property (nonatomic, strong) NSArray *proTimeList;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *dateIcon;
@property (nonatomic, strong) UIView *postView;
@end

@implementation YJDateController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadData];
	[self initUI];
}
-(void)viewWillAppear:(BOOL)animated
{
	self.title = [NSString stringWithFormat:@"预约%@", [self.dicData objectForKey:@"headStr"]];
	self.navigationController.navigationBar.hidden = NO;
}
-(void)loadData
{
	NSDictionary *dic = @{@"加油站":@"\U0000e64b", @"汽车养护":@"\U0000e875",@"紧急呼救":@"\U0000e61b",@"停车场":@"\U0000e608",@"汽车维修":@"\U0000e6a5",@"汽车销售":@"\U0000e613"};
	self.iconData = dic;
}
-(void)initUI
{
	self.view.backgroundColor = [UIColor whiteColor];
	UILabel *image = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 75, 100, 150, 150)];
	image.font = [UIFont fontWithName:@"iconfont" size:100];
	image.layer.cornerRadius = 75;
	image.layer.masksToBounds = YES;
	image.textAlignment = NSTextAlignmentCenter;
	image.backgroundColor = COLOR(151, 225, 138);
	image.textColor = [UIColor redColor];
	image.text = [self.iconData objectForKey:[self.dicData objectForKey:@"headStr"]];
	[self.view addSubview:image];
	
	UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, SCREENWIDTH, 18)];
	name.textAlignment = NSTextAlignmentCenter;
	name.font = [UIFont boldSystemFontOfSize:18.0];
	name.textColor = [UIColor blackColor];
	name.text = [self.dicData objectForKey:@"name"];
	[self.view addSubview:name];
	
	UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, SCREENWIDTH, 16)];
	address.textAlignment = NSTextAlignmentCenter;
	address.font = [UIFont systemFontOfSize:16.0];
	address.textColor = [UIColor grayColor];
	address.text = [self.dicData objectForKey:@"address"];
	[self.view addSubview:address];
	
	UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 90, 326, 180, 130)];
	pickerView.showsSelectionIndicator = YES;
	pickerView.dataSource = self;
	pickerView.delegate = self;
	_proTimeList = [[NSArray alloc]initWithObjects:@"1小时后",@"2小时后",@"3小时后",nil];
	[self.view addSubview:pickerView];
	
	UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 - 100, 500, 200, 40)];
	btnView.backgroundColor = NAVBLUECOLOR;
	btnView.layer.cornerRadius = 5;
	btnView.layer.masksToBounds = YES;
	[self.view addSubview:btnView];
	self.postView = btnView;
	
	UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 80, 26)];
	orderLabel.textColor = [UIColor whiteColor];
	orderLabel.textAlignment = NSTextAlignmentCenter;
	orderLabel.font = [UIFont systemFontOfSize:26.0];
	orderLabel.text = @"预约";
	[btnView addSubview:orderLabel];
	self.dateLabel = orderLabel;
	
	UILabel *postIcon = [[UILabel alloc] initWithFrame:CGRectMake(150, 2.5, 35, 35)];
	postIcon.textColor = [UIColor whiteColor];
	postIcon.textAlignment = NSTextAlignmentCenter;
	postIcon.font = [UIFont fontWithName:@"iconfont" size:35.0];
	postIcon.text = @"\U0000e609";
	[btnView addSubview:postIcon];
	self.dateIcon = postIcon;

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postDate)];
	[btnView addGestureRecognizer:tap];
}

-(void)postDate
{
	NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
	hud.mode = MBProgressHUDModeAnnularDeterminate;
	hud.label.text = @"请稍后";
	[hud hideAnimated:YES afterDelay:5.0];
	
	NSDictionary *paramers = @{@"if": @"DateOrder", @"uid": [self.dicData objectForKey:@"uid"], @"poi_name": [self.dicData objectForKey:@"name"], @"poi_address": [self.dicData objectForKey:@"address"], @"id":user_id};
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager POST:SERVER_ADDRESS parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSNumber *code = [responseObject objectForKey:@"code"];
		if (code.intValue == 1) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			hud.mode = MBProgressHUDModeText;
			hud.label.text = @"预约发送成功！";
			[hud hideAnimated:YES afterDelay:2.0];
			NSMutableDictionary *data = [responseObject objectForKey:@"data"];
			NSString *orderID = [data objectForKey:@"id"];
			[self performSelector:@selector(checkStateWithID:) withObject:orderID afterDelay:5.0];
			dispatch_async(dispatch_get_main_queue(), ^{
				[[self.postView.gestureRecognizers objectAtIndex:0] removeTarget:self action:@selector(postDate)];
				self.dateLabel.text = @"预约中";
				
				CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
				animation.fromValue = [NSNumber numberWithFloat:0.f];
				animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
				animation.duration = 1.0f;
				animation.autoreverses = NO;
				animation.repeatCount = MAXFLOAT;
				animation.removedOnCompletion = NO;
				animation.fillMode = kCAFillModeForwards;
				[self.dateIcon.layer addAnimation:animation forKey:nil];
			});
		}else{
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			hud.mode = MBProgressHUDModeText;
			hud.label.text = @"预约发送失败";
			[hud hideAnimated:YES afterDelay:1];
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeText;
		hud.label.text = @"网络错误！";
		[hud hideAnimated:YES afterDelay:1.0];
	}];
}
-(void)checkStateWithID:(NSString *)orderID
{
	NSDictionary *params = @{@"if": @"CheckOrderState",@"id":orderID};
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager POST:SERVER_ADDRESS parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *tempDic = @{@"name": [self.dicData objectForKey:@"name"], @"address": [self.dicData objectForKey:@"address"], @"state": [responseObject objectForKey:@"data"][@"state"]};
		NSArray *orderStates = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderStates"];
		if (orderStates) {
			NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:orderStates];
			[tempArr addObject:tempDic];
			[[NSUserDefaults standardUserDefaults] setObject:tempArr forKey:@"orderStates"];
		}
		else
		{
			NSMutableArray *arr = [NSMutableArray new];
			[arr addObject:tempDic];
			[[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"orderStates"];
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"订单状态检查失败");
	}];
}

#pragma  mark -- UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [_proTimeList count];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
	return 180;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [_proTimeList objectAtIndex:row];
}
@end
