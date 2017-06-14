//
//  YJLoginViewController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJLoginViewController : UIViewController
@property (strong , nonatomic) UIImageView *Icon;
@property (strong , nonatomic) UITextField *username , *password;
@property (strong , nonatomic) UIButton *User , *Designer , *Login , *GotoRegister;
@property (strong , nonatomic) UILabel *DividingLine;
@property (strong, nonatomic) NSString *mytype;
@end
