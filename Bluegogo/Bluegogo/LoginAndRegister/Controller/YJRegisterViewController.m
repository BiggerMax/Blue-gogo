//
//  YJRegisterViewController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/20.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJRegisterViewController.h"

@interface YJRegisterViewController ()

@end

@implementation YJRegisterViewController
@synthesize Icon;
@synthesize username , password , confirmpassword;
@synthesize User , Designer , Register , BackToLogin;
@synthesize DividingLine1 , DividingLine2;
@synthesize flag;
@synthesize mytype;
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = COLOR(242, 242, 244);
	
	Icon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 100) / 2, SCREENHEIGHT * 0.135, 80, 80)];
	[Icon setImage:[UIImage imageNamed:@"logo"]];
	[self.view addSubview:Icon];
	self.flag = [NSNumber numberWithInt:0];
	mytype = @"user";
	
	UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, SCREENHEIGHT * 0.135 + 130, SCREENWIDTH * 0.92, 120)];
	whiteView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:whiteView];
	
	username = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, 0, SCREENWIDTH * 0.84, 40)];
	username.delegate = self;
	username.backgroundColor = [UIColor whiteColor];
	username.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
	username.font = [UIFont fontWithName:@"Times New Roman" size:12];
	username.placeholder = @"用户名";
	username.autocorrectionType = UITextAutocorrectionTypeNo;
	username.autocapitalizationType = UITextAutocapitalizationTypeNone;
	username.clearButtonMode = UITextFieldViewModeWhileEditing;
	[whiteView addSubview:username];
	
	password = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, 40, SCREENWIDTH * 0.84, 40)];
	password.delegate = self;
	password.backgroundColor = [UIColor whiteColor];
	password.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
	password.font = [UIFont fontWithName:@"Times New Roman" size:12];
	password.placeholder = @"密码";
	password.secureTextEntry = YES;
	password.autocorrectionType = UITextAutocorrectionTypeNo;
	password.autocapitalizationType = UITextAutocapitalizationTypeNone;
	password.clearButtonMode = UITextFieldViewModeWhileEditing;
	[whiteView addSubview:password];
	
	confirmpassword = [[UITextField alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, 80, SCREENWIDTH * 0.84, 40)];
	confirmpassword.delegate = self;
	confirmpassword.backgroundColor = [UIColor whiteColor];
	confirmpassword.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
	confirmpassword.font = [UIFont fontWithName:@"Times New Roman" size:12];
	confirmpassword.placeholder = @"再次确认密码";
	confirmpassword.secureTextEntry = YES;
	confirmpassword.autocorrectionType = UITextAutocorrectionTypeNo;
	confirmpassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
	confirmpassword.clearButtonMode = UITextFieldViewModeWhileEditing;
	//    [confirmpassword addTarget:self action:@selector(didDone:) forControlEvents:UIControlEventEditingDidEnd];
	[whiteView addSubview:confirmpassword];
	
	DividingLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH * 0.92, 1/[UIScreen mainScreen].scale)];
	DividingLine1.layer.borderColor = [[UIColor colorWithRed:166/255.0 green:166/255.0  blue:166/255.0  alpha:1] CGColor];
	DividingLine1.layer.borderWidth = 1;
	[whiteView addSubview:DividingLine1];
	
	DividingLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH * 0.92, 1/[UIScreen mainScreen].scale)];
	DividingLine2.layer.borderColor = [[UIColor colorWithRed:166/255.0 green:166/255.0  blue:166/255.0  alpha:1] CGColor];
	DividingLine2.layer.borderWidth = 1;
	[whiteView addSubview:DividingLine2];
	
	Register = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.04, SCREENHEIGHT * 0.135 + 265, SCREENWIDTH * 0.92, 40)];
	Register.layer.cornerRadius = 4;
	Register.layer.masksToBounds = YES;
	[Register setTitle:@"立即注册" forState:UIControlStateNormal];
	Register.titleLabel.font = [UIFont systemFontOfSize:15];
	[Register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[Register setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1]];
	[Register addTarget:self action:@selector(PushRegister:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:Register];
	
	BackToLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT * 0.135 + 330, SCREENWIDTH, 20)];
	[BackToLogin setTitle:@"返回登录" forState:UIControlStateNormal];
	BackToLogin.titleLabel.font = [UIFont systemFontOfSize:12];
	[BackToLogin setTitleColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:118/255.0 alpha:1] forState:UIControlStateNormal];
	[BackToLogin addTarget:self action:@selector(backtoLoginViewController:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:BackToLogin];

	
}
-(void)backtoLoginViewController:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)PushRegister:(id)sender
{
	[username resignFirstResponder];
	[password resignFirstResponder];
	NSString *user = username.text;
	NSString *psw = password.text;
	NSString *ps_r = confirmpassword.text;
	if (user.length <= 0 || user.length < 6) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeText;
		hud.label.text = @"请输入6位以上用户名";
		[hud hideAnimated:YES afterDelay:1.0f];
	}else if (psw.length <= 6){
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeText;
		hud.label.text = @"请输入6位以上密码";
		[hud hideAnimated:YES afterDelay:1];

	}else if (![psw isEqualToString:ps_r]){
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeText;
		hud.label.text = @"两次输入密码不一致";
		[hud hideAnimated:YES afterDelay:1];
	}else
	{
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.mode = MBProgressHUDModeIndeterminate;
		hud.label.text = @"加载中";
		[hud hideAnimated:YES afterDelay:5];

		NSDictionary *paramers = @{@"if": @"Register", @"username": user, @"password":psw};
		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		[manager POST:SERVER_ADDRESS parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
			
		} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			NSNumber *code = [responseObject objectForKey:@"code"];
			if (code.intValue == 1)
			{
				[MBProgressHUD hideHUDForView:self.view animated:YES];
				MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
				hud.mode = MBProgressHUDModeText;
				hud.label.text = @"注册成功，快去登录吧";
				[hud hideAnimated:YES afterDelay:1.0];
				[self.navigationController popViewControllerAnimated:YES];
				confirmpassword.text = nil;
				username.text = nil;
				password.text = nil;
				[username resignFirstResponder];
				[password resignFirstResponder];
				[confirmpassword resignFirstResponder];
			}else{
				[MBProgressHUD hideHUDForView:self.view animated:YES];
				MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
				hud.mode = MBProgressHUDModeText;
				hud.label.text = @"此账户已注册，换个账户吧";
				[hud hideAnimated:YES afterDelay:1];
				confirmpassword.text = nil;
				username.text = nil;
				password.text = nil;
				[username resignFirstResponder];
				[password resignFirstResponder];
				[confirmpassword resignFirstResponder];
			}
		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];
			MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			hud.mode = MBProgressHUDModeText;
			hud.label.text = @"注册失败，请稍微重试!";
			[hud hideAnimated:YES afterDelay:1];
		}];
	}
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame = textField.frame;
	
	int offset = frame.origin.y + 83 - (self.view.frame.size.height - 216.0);
	
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];

	if(offset > 0)
		self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
	
	[UIView commitAnimations];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	if (textField == confirmpassword) {
		NSString *str1 = password.text;
		NSString *str2 = confirmpassword.text;
		if(![str1 isEqualToString:str2])
		{
			self.flag = [NSNumber numberWithInt:1];
			confirmpassword.text = nil;
		}

	}
	return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
	
	[username resignFirstResponder];
	[password resignFirstResponder];
	[confirmpassword resignFirstResponder];
}

@end
