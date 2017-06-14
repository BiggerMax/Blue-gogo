//
//  YJEditInfoController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/14.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserViewDelegate <NSObject>

-(void)reloadTableWithNickName:(NSString *)nickName andCar:(NSString *)car;

@end
@interface YJEditInfoController : UIViewController
@property(nonatomic,weak) id<UserViewDelegate>delegate;
@property(nonatomic,strong)NSMutableDictionary *vcData;
@end
