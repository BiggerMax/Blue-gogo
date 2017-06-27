//
//  YJDepartViewController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/26.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface YJDepartViewController : UIViewController
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, assign) BOOL canDate;
@end
