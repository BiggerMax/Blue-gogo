//
//  YJInfoCell.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/5.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJInfoCell.h"


@implementation YJInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		self.contentView.backgroundColor = [UIColor whiteColor];
		UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 160, 88)];
		[self.contentView addSubview:imageview];
		self.icon = imageview;
		//
		UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(175, 15, SCREENWIDTH - 195, 40)];
		title.textAlignment = NSTextAlignmentLeft;
		title.font = [UIFont boldSystemFontOfSize:14.0];
		title.lineBreakMode = NSLineBreakByWordWrapping;
		title.numberOfLines = 0;
		[self.contentView addSubview:title];
		self.titleLabel = title;
		
		UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(175, 70, 60, 10)];
		time.textAlignment = NSTextAlignmentLeft;
		time.font = [UIFont fontWithName:@"iconfont" size:10.0];
		time.textColor = [UIColor grayColor];
		[self.contentView addSubview:time];
		self.timeLabel = time;
		
		UILabel *source = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 90, 70, 80, 10)];
		source.textAlignment = NSTextAlignmentLeft;
		source.font = [UIFont fontWithName:@"iconfont" size:10.0];
		source.textColor = [UIColor grayColor];
		[self.contentView addSubview:source];
		self.sourceLabel = source;
		
		UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 2)];
		line.backgroundColor = [UIColor colorWithRed:225 green:230 blue:234 alpha:1];
		[self.contentView addSubview:line];
		
	}
	return self;
}

@end
