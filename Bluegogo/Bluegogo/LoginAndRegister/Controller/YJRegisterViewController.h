//
//  YJRegisterViewController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/20.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJRegisterViewController : UIViewController<UITextFieldDelegate>
@property (strong , nonatomic) UIImageView *Icon;
@property (strong , nonatomic) UITextField *username , *password , *confirmpassword;
@property (strong , nonatomic) UIButton *User , *Designer , *Register , *BackToLogin;
@property (strong , nonatomic) UILabel *DividingLine1 , *DividingLine2;
@property (strong, nonatomic) NSNumber *flag;
@property (strong, nonatomic) NSString *mytype;
@end
