//
//  YJHomeTopView.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/25.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTopViewDelegate <NSObject>
- (void) reLocateBtnClick;
- (void) weatherInfo;
@end

@interface YJHomeTopView : UIView
@property(nonatomic,strong) UILabel *locationLabel;
@property(nonatomic,strong) UILabel *locationImage;
@property(nonatomic,strong) UIButton *weatherBtn;
@property(nonatomic,strong) UILabel *temperatureLabel;
@property(nonatomic,strong) UILabel *weatherLabel;
@property(nonatomic,strong) UILabel *notisNum;
@property(nonatomic,strong) UIView *locationView;
@property(nonatomic,weak)id <HomeTopViewDelegate> delegate;
@end
