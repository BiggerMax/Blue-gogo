//
//  YJLoginController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/20.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJLoginController : UIViewController<UITextFieldDelegate>
@property (strong , nonatomic) UIImageView *Icon;
@property (strong , nonatomic) UITextField *usernameTF , *passwordTF;
@property (strong , nonatomic) UIButton *UserBtn , *DesignerBtn , *LoginBtn , *GotoRegisterBtn;
@property (strong , nonatomic) UILabel *DividingLine;
@property (strong, nonatomic) NSString *mytype;
@end
