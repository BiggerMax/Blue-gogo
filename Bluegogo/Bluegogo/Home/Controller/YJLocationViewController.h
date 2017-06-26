//
//  YJLocationViewController.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/26.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationViewDelegate <NSObject>

-(void)reLocate;

@end
@interface YJLocationViewController : UIViewController
@property (nonatomic, strong) NSString *locationStr;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSMutableArray *pois;
@property (nonatomic, weak) id<LocationViewDelegate> delegate;
@end
