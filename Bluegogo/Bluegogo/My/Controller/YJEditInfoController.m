//
//  YJEditInfoController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJEditInfoController.h"

@interface YJEditInfoController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textField;
@end

@implementation YJEditInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initUI];
}
-(void)initUI{
	self.view.backgroundColor = COLOR(245, 245, 245);
	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
	UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
	self.navigationItem.leftBarButtonItem = back;
	
	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = save;
	self.title = [self.vcData objectForKey:@"title"];
	
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 84, SCREENWIDTH, 40)];
	textField.backgroundColor = [UIColor whiteColor];
	textField.layer.borderWidth = 0.5f;
	textField.layer.borderColor = BGGRAYCOLOR.CGColor;
	textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
	textField.leftViewMode = UITextFieldViewModeAlways;
	textField.clearButtonMode = UITextFieldViewModeAlways;
	if (![[self.vcData objectForKey:@"holder"] isEqualToString:@"暂无"]) {
		textField.text = [self.vcData objectForKey:@"holder"];
		
	}
	textField.delegate = self;
	[self.view addSubview:textField];
	self.textField = textField;
}
-(void)save{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.mode = MBProgressHUDModeIndeterminate;
	hud.label.text = @"正在加载";
	[hud hideAnimated:YES afterDelay:5.0f];
	
	NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
	NSDictionary *paramers = @{@"if": [self.vcData objectForKey:@"if"], [self.vcData objectForKey:@"post_key"]: self.textField.text,@"id":user_id};
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager POST:SERVER_ADDRESS parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSNumber *code = [responseObject objectForKey:@"code"];
		if (code.intValue == 1) {
			[self.delegate respondsToSelector:@selector(reloadTableWithNickName:andCar:)];
			if ([[self.vcData objectForKey:@"post_key"] isEqualToString:@"nickname"]) {
               NSString *nickname = self.textField.text;
				[self.delegate reloadTableWithNickName:nickname andCar:nil];
			}
			else{
				NSString *car = self.textField.text;
				[self.delegate reloadTableWithNickName:nil andCar:car];
			}
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			[[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:[self.vcData objectForKey:@"post_key"]];
			[[NSUserDefaults standardUserDefaults] synchronize];
			[self.navigationController popViewControllerAnimated:YES];
		}
		else{
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			hud.mode = MBProgressHUDModeText;
			hud.label.text = @"更改失败";
			[hud hideAnimated:YES afterDelay:1];
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeText;
		hud.label.text = @"网络错误";
		[hud hideAnimated:YES afterDelay:1];
	}];
}
-(void)back{
	[self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self.textField resignFirstResponder];
}
-(BOOL)becomeFirstResponder{
	[super becomeFirstResponder];
	return [self.textField becomeFirstResponder];
}
@end
