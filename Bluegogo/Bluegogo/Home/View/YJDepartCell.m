//
//  YJDepartCell.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/26.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJDepartCell.h"

@implementation YJDepartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
		line.backgroundColor = BGGRAYCOLOR;
		[self.contentView addSubview:line];
		UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, SCREENWIDTH * 0.6, 16)];
		name.textAlignment = NSTextAlignmentLeft;
		name.font = [UIFont boldSystemFontOfSize:16.0];
		name.textColor = [UIColor blackColor];
		[self.contentView addSubview:name];
		self.name = name;
		UIView *date = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.6 + 16, 25, 20, 20)];
		UILabel *dating = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		dating.font = [UIFont fontWithName:@"iconfont" size:20.0];
		dating.textAlignment = NSTextAlignmentCenter;
		dating.textColor = NAVBLUECOLOR;
		dating.text = @"\U0000e601";
		[date addSubview:dating];
		UITapGestureRecognizer *datingClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datingClick)];
		[date addGestureRecognizer:datingClick];
		self.datingBtn = date;
		
		UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(15, 64, 50, 14)];
		distance.textAlignment = NSTextAlignmentLeft;
		distance.font = [UIFont systemFontOfSize:14.0];
		distance.textColor = [UIColor grayColor];
		[self.contentView addSubview:distance];
		self.distance = distance;
		
		UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(70, 64, SCREENWIDTH * 0.6 - 55, 14)];
		location.textAlignment = NSTextAlignmentLeft;
		location.font = [UIFont systemFontOfSize:14.0];
		location.textColor = [UIColor grayColor];
		[self.contentView addSubview:location];
		self.location = location;
		
		UIView *call = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.72, 22, 30, 50)];
		UILabel *callIcon = [[UILabel alloc] initWithFrame:CGRectMake(1.5, 0, 27, 27)];
		callIcon.textColor = NAVBLUECOLOR;
		callIcon.font = [UIFont fontWithName:@"iconfont" size:27.0];
		callIcon.text = @"\U0000e614";
		callIcon.textAlignment = NSTextAlignmentCenter;
		[call addSubview:callIcon];
		UILabel *callTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 31, 30, 14)];
		callTip.text = @"电话";
		callTip.textColor = NAVBLUECOLOR;
		callTip.font = [UIFont systemFontOfSize:12.0];
		callTip.textAlignment = NSTextAlignmentCenter;
		[call addSubview:callTip];
		[self.contentView addSubview:call];
		UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callClick)];
		[call addGestureRecognizer:tapGestureRecognizer];
		
		UIView *guide = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.72 + 40, 25, 45, 47)];
		UILabel *guideIcon = [[UILabel alloc] initWithFrame:CGRectMake(9, 0, 27, 27)];
		guideIcon.textColor = NAVBLUECOLOR;
		guideIcon.font = [UIFont fontWithName:@"iconfont" size:27.0];
		guideIcon.text = @"\U0000e73b";
		guideIcon.textAlignment = NSTextAlignmentCenter;
		[guide addSubview:guideIcon];
		UILabel *guideTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 45, 14)];
		guideTip.text = @"去这里";
		guideTip.textColor = NAVBLUECOLOR;
		guideTip.font = [UIFont systemFontOfSize:12.0];
		guideTip.textAlignment = NSTextAlignmentCenter;
		[guide addSubview:guideTip];
		[self.contentView addSubview:guide];

		UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviClick)];
		[guide addGestureRecognizer:tapGestureRecognizer2];

	}
	return self;
}
- (void)callClick
{
	[self.delegate respondsToSelector:@selector(callNumber:)];
	[self.delegate callNumber:self.tel];
	NSLog(@"clicked!!!");
}
- (void)naviClick
{
	[self.delegate respondsToSelector:@selector(naviForIndex:)];
	[self.delegate naviForIndex:self.index];
}
- (void)datingClick
{
	NSLog(@"date");
	[self.delegate respondsToSelector:@selector(date)];
	[self.delegate date];
}
@end
