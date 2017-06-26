//
//  YJHomeTopView.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/25.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeTopView.h"

@implementation YJHomeTopView

-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self initUI];
	}
	return self;
}
-(void)initUI
{
	self.backgroundColor = NAVBLUECOLOR;
	
	UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(10, 45, 20 + SCREENWIDTH * 0.5, 20)];
	
	locationView.backgroundColor = [UIColor clearColor];
	_locationImage = [[UILabel alloc] init];
	_locationImage.frame = CGRectMake(0, 0, 22, 22);
	_locationImage.font = [UIFont fontWithName:@"iconfont" size:20.0f];
	_locationImage.text = @"\U0000e8ba";
	_locationImage.textColor = [UIColor whiteColor];
	[locationView addSubview:_locationImage];
	
	UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, SCREENWIDTH / 2, 20)];
	locationLabel.textColor = [UIColor whiteColor];
	locationLabel.font = [UIFont systemFontOfSize:20];
	locationLabel.textAlignment = NSTextAlignmentLeft;
	[locationView addSubview:locationLabel];
	self.locationLabel = locationLabel;
	[self addSubview:locationView];
	
	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reLocatingClick:)];
	[locationView addGestureRecognizer:gesture];
	
	self.locationView = locationView;
	
	
	_temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.75, 40, SCREENWIDTH * 0.08, 15)];
	_temperatureLabel.textColor = [UIColor whiteColor];
	_temperatureLabel.font = [UIFont systemFontOfSize:15];
	_temperatureLabel.textAlignment = NSTextAlignmentCenter;
	[self addSubview:_temperatureLabel];
	
	_weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.75, 56, SCREENWIDTH * 0.08, 12)];
	_weatherLabel.textAlignment = NSTextAlignmentCenter;
	_weatherLabel.textColor = [UIColor whiteColor];
	_weatherLabel.font = [UIFont systemFontOfSize:12.0f];
	[self addSubview:_weatherLabel];
	
	_weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_weatherBtn.frame = CGRectMake(SCREENWIDTH * 0.85, 40, 26, 26);
	[_weatherBtn setTitle:@"\U0000e605" forState:UIControlStateNormal];
	_weatherBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:26.0];
	[_weatherBtn addTarget:self action:@selector(weatherBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_weatherBtn];
	
	_notisNum = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.85 + 26, 40, 10, 10)];
	_notisNum.backgroundColor = [UIColor redColor];
	_notisNum.textColor = [UIColor whiteColor];
	_notisNum.textAlignment = NSTextAlignmentCenter;
	_notisNum.font = [UIFont systemFontOfSize:8.0f];
	_notisNum.layer.cornerRadius = 5.0f;
	_notisNum.layer.masksToBounds = YES;
	[self addSubview:_notisNum];
}
-(void)reLocatingClick:(UITapGestureRecognizer *)gesture
{
	[self.delegate respondsToSelector:@selector(reLocateBtnClick)];
	[self.delegate reLocateBtnClick];
}
-(void)weatherBtnClick
{
	[self.delegate respondsToSelector:@selector(weatherInfo)];
	[self.delegate weatherInfo];
}
@end
