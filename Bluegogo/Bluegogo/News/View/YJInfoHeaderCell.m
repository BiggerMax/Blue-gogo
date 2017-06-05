//
//  YJInfoHeaderCell.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/5.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJInfoHeaderCell.h"

@implementation YJInfoHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		self.contentView.backgroundColor = [UIColor whiteColor];
		UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
		[self.contentView addSubview:imageView];
		self.icon = imageView;
		
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, SCREENWIDTH, 20)];
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
		self.titleLabel.textColor = [UIColor blackColor];
		[self.icon addSubview:self.titleLabel];
		
	}
	return self;
}
@end
