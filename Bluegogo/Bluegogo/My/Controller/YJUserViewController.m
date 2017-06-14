//
//  YJUserViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJUserViewController.h"
#import "YJAffairListCell.h"
#import "YJEditInfoController.h"
@interface YJUserViewController ()<UITableViewDelegate,UITableViewDataSource,UserViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableData;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *car;
@end

@implementation YJUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self loadData];
	[self initUI];
}
-(void)viewWillAppear:(BOOL)animated
{
	self.title = @"个人信息";
}
-(void)reloadTableWithNickName:(NSString *)nickName andCar:(NSString *)car
{
	if (nickName) {
		self.nickname = nickName;
	}
	if (car) {
		self.car = car;
	}
	[self.tableView reloadData];
}
-(void)loadData
{
	NSArray *array = @[@{@"affair": @"用户昵称", @"icon": @"\U0000e634", @"holder": @""}, @{@"affair": @"车牌号", @"icon": @"\U0000e89e", @"holder": @""}];
	self.tableData = array;
	_nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
	_car = [[NSUserDefaults standardUserDefaults] objectForKey:@"car"];

}
-(void)initUI
{
	self.view.backgroundColor = COLOR(245, 245, 245);
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH-80)/2, 120, 80, 80)];
	image.layer.cornerRadius = 40;
	image.layer.masksToBounds = YES;
	[image setImage:[UIImage imageNamed:@"logo"]];
	[self.view addSubview:image];
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, SCREENWIDTH, 80) style:UITableViewStylePlain];
	tableView.scrollEnabled = NO;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.delegate = self;
	tableView.dataSource = self;
	[tableView registerClass:[YJAffairListCell class] forCellReuseIdentifier:@"MyCell"];
	[self.view addSubview:tableView];
	self.tableView = tableView;
}
#pragma mark --UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.tableData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJAffairListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyCell"];
	cell.affair.text = self.tableData[indexPath.row][@"affair"];
	cell.affairIcon.text = self.tableData[indexPath.row][@"icon"];
	if (indexPath.row == 0) {
		if ([_nickname isEqualToString:@""]) {
			cell.holderLabel.text = @"暂无";
		}
		else{
			cell.holderLabel.text = _nickname;
		}
	}
	if (indexPath.row == 1) {
		if ([_car isEqualToString:@""]) {
			cell.holderLabel.text = @"暂无";
		}else{
			cell.holderLabel.text = _car;
		}
	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	YJEditInfoController *editVC = [YJEditInfoController new];
	editVC.delegate = self;
	NSMutableDictionary *tempDic = [NSMutableDictionary new];
	[tempDic setObject:[self.tableData objectAtIndex:indexPath.row][@"affair"] forKey:@"title"];
	if (indexPath.row == 0) {
		[tempDic setObject:_nickname forKey:@"holder"];
		[tempDic setObject:@"EditNickName" forKey:@"if"];
		[tempDic setObject:@"nickname" forKey:@"post_key"];
	}
	else{
		[tempDic setObject:_car forKey:@"holder"];
		[tempDic setObject:@"EditCar" forKey:@"if"];
		[tempDic setObject:@"car" forKey:@"post_key"];
	}
	editVC.vcData = tempDic;
	[self.navigationController pushViewController:editVC animated:YES];
}
@end
