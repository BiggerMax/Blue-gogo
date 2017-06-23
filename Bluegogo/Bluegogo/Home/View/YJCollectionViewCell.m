//
//  YJCollectionViewCell.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/24.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJCollectionViewCell.h"

@implementation YJCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		CGFloat width = self.frame.size.width;
		UILabel *image = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.325, width * 0.1, width * 0.34, width * 0.34)];
		image.font = [UIFont fontWithName:@"iconfont" size:width * 0.175];
		image.layer.cornerRadius = width * 0.175;
		image.layer.masksToBounds = YES;
		image.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:image];
		self.itemIcon = image;
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, width * 0.6, width, 15)];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.font = [UIFont systemFontOfSize:15.0];
		[self.contentView addSubview:label];
		self.itemName = label;

	}
	return self;
}
@end
