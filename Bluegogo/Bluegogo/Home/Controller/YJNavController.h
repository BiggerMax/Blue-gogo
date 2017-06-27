//
//  YJNavController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/27.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
@interface YJNavController : UIViewController
@property(nonatomic,strong)AMapNaviPoint *starPoint;
@property(nonatomic,strong)AMapNaviPoint *endPoint;
@end
