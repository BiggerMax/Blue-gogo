//
//  YJMyViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMyViewController.h"
#import "YJAffairListCell.h"
#import "YJUserViewController.h"
@interface YJMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *carImage;
@property (nonatomic, strong) UILabel *nickname;
@property (nonatomic, strong) UITableView *affairList;
@property (nonatomic, strong) NSArray *affairArr;
@property (nonatomic, strong) NSArray *settingArr;

@end

@implementation YJMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadData];
	[self initUI];
	__block NSInteger value = 0;
	void(^block)(void) = ^{
		value =1 ;
	};
	block();

}
-(void)loadData{
	NSArray *array = @[@{@"affair": @"个人信息", @"icon": @"\U0000e89e", @"holder": @""}, @{@"affair": @"历史预定", @"icon": @"\U0000e61a", @"holder": @""}, @{@"affair": @"历史足迹", @"icon": @"\U0000e8d0", @"holder": @""}, @{@"affair": @"我的积分", @"icon": @"\U0000e86e", @"holder": @""}];
	self.affairArr = array;
	
	NSArray *temp = @[@{@"affair": @"清除缓存", @"icon": @"\U0000e8c1", @"holder": @"200K"}, @{@"affair": @"退出登录", @"icon": @"\U0000e603", @"holder": @""}];
	self.settingArr = temp;
	
}
-(void)initUI{
	
	self.view.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH -80) / 2, 120, 80, 80)];
	image.layer.cornerRadius = 40;
	image.layer.masksToBounds = YES;
	[image setImage:[UIImage imageNamed:@"logo"]];
	[self.view addSubview:image];
	self.carImage = image;
	
	UILabel *nickname = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, SCREENWIDTH, 20)];
	nickname.font = [UIFont systemFontOfSize:15.0];
	nickname.textColor = [UIColor blackColor];
	nickname.text = @"NickName";
	nickname.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:nickname];
	self.nickname = nickname;
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, SCREENWIDTH, 20 + self.affairArr.count * 40 + self.settingArr.count * 40) style:UITableViewStylePlain];
	tableView.scrollEnabled = NO;
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[tableView registerClass:[YJAffairListCell class] forCellReuseIdentifier:@"AffairCell"];
	[self.view addSubview:tableView];
	self.affairList = tableView;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (section == 0) {
		return self.affairArr.count;
	}else
		return self.settingArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	YJAffairListCell *cell = [self.affairList dequeueReusableCellWithIdentifier:@"AffairCell"];
	if (indexPath.section == 0) {
		cell.affair.text = self.affairArr[indexPath.row][@"affair"];
		cell.affairIcon.text = self.affairArr[indexPath.row][@"icon"];
		cell.holderLabel.text = self.affairArr[indexPath.row][@"holder"];
	}else{
		cell.affair.text = self.settingArr[indexPath.row][@"affair"];
		cell.affairIcon.text = self.settingArr[indexPath.row][@"icon"];
		if (indexPath.row == 0){
			NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
			if (cacheSize/1024.0 >= 1.0){
				cell.holderLabel.text = [NSString stringWithFormat:@"%.2fM", cacheSize/1024.0/1024.0];
			}
			else{
				cell.holderLabel.text = [NSString stringWithFormat:@"%.2fK", cacheSize/1024.0];
			}
		}

	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0 && indexPath.row == 0) {
		YJUserViewController *userVC = [YJUserViewController new];
		[self.navigationController pushViewController:userVC animated:YES];
	}
	if (indexPath.section == 1 && indexPath.row == 1) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
		[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			[alert dismissViewControllerAnimated:YES completion:nil];
		}]];
		[alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"id"];
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"car"];
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderStates"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}]];
		[self presentViewController:alert animated:YES completion:nil];
	}
	if (indexPath.section == 1 && indexPath.row == 0) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeIndeterminate;
		hud.label.text = @"请稍后";
		[hud hideAnimated:YES afterDelay:1.0f];
		[[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
			[[SDImageCache sharedImageCache] clearMemory];
			[self refreshCache];
		}];
	}
//	if (indexPath.section == 0 && indexPath.row == 2) {
//		<#statements#>
//	}
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
	headerView.backgroundColor = COLOR(245, 245, 245);
	return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 10;
}
-(void)viewWillAppear:(BOOL)animated
{
	[self refreshCache];
}
-(void)refreshCache
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSIndexPath *refreshIndex = [NSIndexPath indexPathForRow:0 inSection:0];
		[self.affairList reloadRowsAtIndexPaths:[NSArray arrayWithObjects:refreshIndex, nil] withRowAnimation:UITableViewRowAnimationNone];
	});
}
@end
