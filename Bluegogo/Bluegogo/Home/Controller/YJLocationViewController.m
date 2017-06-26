//
//  YJLocationViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/26.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJLocationViewController.h"

@interface YJLocationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YJLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
}
-(void)initUI
{
	self.view.backgroundColor = COLOR(244, 245, 246);
	UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
	top.backgroundColor = NAVBLUECOLOR;
	[self.view addSubview:top];
	
	UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(15, 35, 25, 25)];
	[close setTitle:@"\U0000e86d" forState:UIControlStateNormal];
	close.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25.0f];
	
	[close addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[top addSubview:close];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.25, 35, SCREENWIDTH * 0.5, 20)];
	titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.text = @"定位当前地址";
	[top addSubview:titleLabel];
	
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 200, 15)];
	headerLabel.font = [UIFont systemFontOfSize:15];
	headerLabel.textAlignment = NSTextAlignmentLeft;
	headerLabel.textColor = COLOR(101, 102, 103);
	headerLabel.text = @"当前地址";
	[self.view addSubview:headerLabel];
	
	UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(0, 145, SCREENWIDTH, 45)];
	locationView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:locationView];
	
	UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREENWIDTH * 0.6, 15)];
	location.textColor = COLOR(51, 52, 53);
	location.textAlignment = NSTextAlignmentLeft;
	location.font = [UIFont systemFontOfSize:15];
	location.text = self.locationStr;
	self.locationLabel = location;
	[locationView addSubview:location];
	
	UIButton *reLocate = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 90, 15, 80, 15)];
	[reLocate setTitle:@"\U0000e8a4 重新定位" forState:UIControlStateNormal];
	[reLocate setTitleColor:COLOR(26, 152, 252) forState:UIControlStateNormal];
	reLocate.titleLabel.font = [UIFont fontWithName:@"iconfont" size:15.0f];
	reLocate.contentHorizontalAlignment = NSTextAlignmentRight;
	[reLocate addTarget:self action:@selector(reLocateClick) forControlEvents:UIControlEventTouchUpInside];
	[locationView addSubview:reLocate];
	
	UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 215, 200, 15)];
	middleLabel.font = [UIFont systemFontOfSize:15];
	middleLabel.textAlignment = NSTextAlignmentLeft;
	middleLabel.textColor = COLOR(101, 102, 103);
	middleLabel.text = @"附近地址";
	[self.view addSubview:middleLabel];
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, SCREENWIDTH, 135) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorInset = UIEdgeInsetsMake(0, 1, 0, 1);
	[self.view addSubview:tableView];
	
}
-(void)closeBtnClick
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)reLocateClick
{
	[self.delegate respondsToSelector:@selector(reLocate)];
	[self.delegate reLocate];
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

#pragma  mark TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.pois count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [UITableViewCell new];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	cell.textLabel.textColor = COLOR(51, 52, 53);
	cell.textLabel.textAlignment = NSTextAlignmentLeft;
	cell.textLabel.text = self.pois[indexPath.row];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[[NSUserDefaults standardUserDefaults] setObject:self.pois[indexPath.row] forKey:@"address"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSNotification *changeAddNotice = [[NSNotification alloc] initWithName:@"changeAddress" object:nil userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:changeAddNotice];
	[self closeBtnClick];

}
@end
