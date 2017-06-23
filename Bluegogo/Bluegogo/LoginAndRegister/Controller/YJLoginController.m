//
//  YJLoginController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/20.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJLoginController.h"
#import "YJRegisterViewController.h"
@interface YJLoginController ()

@end

@implementation YJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	self.view.backgroundColor = COLOR(242, 242, 244);
	
	self.Icon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH-80)/2, SCREENWIDTH * 0.142, 80, 80)];
	[self.Icon setImage:[UIImage imageNamed:@"logo"]];
	[self.view addSubview:self.Icon];
	
	UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, SCREENHEIGHT * 0.142 + 150, SCREENWIDTH * 0.92, 80)];
	whiteView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:whiteView];
	
	self.usernameTF = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, 0, SCREENWIDTH * 0.84, 40)];
	self.usernameTF.delegate = self;
	self.usernameTF.backgroundColor = [UIColor clearColor];
	self.usernameTF.textColor = COLOR(166, 166, 166);
	self.usernameTF.font = [UIFont fontWithName:@"Times New Roman" size:12];
	self.usernameTF.placeholder = @"用户名";
	self.usernameTF.autocorrectionType = UITextAutocorrectionTypeNo;
	self.usernameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.usernameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
	[whiteView addSubview:self.usernameTF];
	
	self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, 40, SCREENWIDTH * 0.84, 40)];
	self.passwordTF.delegate = self;
	self.passwordTF.backgroundColor = [UIColor whiteColor];
	self.passwordTF.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
	self.passwordTF.font = [UIFont fontWithName:@"Times New Roman" size:12];
	self.passwordTF.placeholder = @"请输入密码";
	self.passwordTF.secureTextEntry = YES;
	self.passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;
	self.passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
	[whiteView addSubview:self.passwordTF];
	
	self.DividingLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH * 0.92, 1/[UIScreen mainScreen].scale)];
	self.DividingLine.layer.borderColor = COLOR(166, 166, 166).CGColor;
	self.DividingLine.layer.borderWidth = 1;
	[whiteView addSubview:self.DividingLine];
	
	self.LoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, SCREENHEIGHT * 0.142 + 245, SCREENWIDTH * 0.92, 40)];
	self.LoginBtn.layer.cornerRadius = 4;
	self.LoginBtn.layer.masksToBounds = YES;
	[self.LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
	self.LoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
	[self.LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.LoginBtn setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1]];
	[self.LoginBtn addTarget:self action:@selector(Loginclicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.LoginBtn];
	
	self.GotoRegisterBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT * 0.142 + 310, SCREENWIDTH, 20)];
	[self.GotoRegisterBtn setTitle:@"没有账号？快来注册" forState:UIControlStateNormal];
	self.GotoRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
	[self.GotoRegisterBtn setTitleColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1] forState:UIControlStateNormal];
	[self.GotoRegisterBtn addTarget:self action:@selector(gotoRegisterViewController:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.GotoRegisterBtn];

}

-(void)Loginclicked:(UIButton *)sender
{
	if ([self.usernameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""]) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeText;
		hud.label.text = @"请正确输入用户名和密码";
		[hud hideAnimated:YES afterDelay:1.0f];
	}else
	{
		NSString *name = self.usernameTF.text;
		NSString *psw = self.passwordTF.text;
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeIndeterminate;
		hud.label.text = @"加载中";
		[hud hideAnimated:YES afterDelay:2.0];
		
		NSDictionary *paramers = @{@"if": @"Login", @"username": name, @"password":psw};
		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		[manager POST:SERVER_ADDRESS parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
			
		} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			NSNumber *number = [responseObject objectForKey:@"code"];
			if (number.integerValue == 1) {
				[MBProgressHUD hideHUDForView:self.view animated:YES];
				MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
				hud.mode = MBProgressHUDModeText;
				hud.label.text = @"登录成功！";
				[hud hideAnimated:YES afterDelay:2.0];
				NSMutableDictionary *singledic = [responseObject objectForKey:@"data"];
				
				[[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"username"] forKey:@"username"];
				[[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"nickname"] forKey:@"nickname"];
				[[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"id"] forKey:@"id"];
				[[NSUserDefaults standardUserDefaults] setObject:[singledic objectForKey:@"car"] forKey:@"car"];
				
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				NSNotification *postAddPlaceNotice = [[NSNotification alloc] initWithName:@"postAddPlace" object:nil userInfo:nil];
				[[NSNotificationCenter defaultCenter] postNotification:postAddPlaceNotice];
				[[NSNotificationCenter defaultCenter] postNotificationName:@"addOrderStates" object:nil];
				[self dismissViewControllerAnimated:YES completion:NULL];
			}else{
				[MBProgressHUD hideHUDForView:self.view animated:YES];
				MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
				hud.mode = MBProgressHUDModeText;
				hud.label.text = @"登录失败";
				[hud hideAnimated:YES afterDelay:1];
				self.usernameTF.text = nil;
				self.passwordTF.text = nil;
				[self.usernameTF resignFirstResponder];
				[self.passwordTF resignFirstResponder];

			}
		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			hud.mode = MBProgressHUDModeText;
			hud.label.text = @"网络错误！";
			[hud hideAnimated:YES afterDelay:1.0];
		}];
	}
	
}
-(void)gotoRegisterViewController:(UIButton *)sender
{
	YJRegisterViewController *registerVC = [YJRegisterViewController new];
	[self.navigationController pushViewController:registerVC animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame = textField.frame;
	
	int offset = frame.origin.y + 83 - (self.view.frame.size.height - 216.0);
	
	NSTimeInterval animationDuration = 0.3f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	
	if (offset > 0) {
		self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
	}
	[UIView commitAnimations];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[self.usernameTF resignFirstResponder];
	[self.passwordTF resignFirstResponder];
}
@end
