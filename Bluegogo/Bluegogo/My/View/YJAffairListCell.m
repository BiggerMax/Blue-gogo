//
//  YJAffairListCell.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJAffairListCell.h"

@implementation YJAffairListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
		line.backgroundColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
		[self addSubview:line];
		
		UILabel *icon = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
		icon.font = [UIFont fontWithName:@"iconfont" size:20];
		icon.textColor = [UIColor colorWithRed:40/255.0f green:158/255.0f blue:252/255.0f alpha:1];
		[self addSubview:icon];
		self.affairIcon = icon;
		
		UILabel *affair = [[UILabel alloc] initWithFrame:CGRectMake(50, 12.5, SCREENWIDTH * 0.6, 15)];
		affair.font = [UIFont systemFontOfSize:15.0];
		[self addSubview:affair];
		self.affair = affair;
		
		UILabel *holder = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.7, 14, SCREENWIDTH * 0.2, 12)];
		holder.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];;
		holder.textAlignment = NSTextAlignmentRight;
		holder.font = [UIFont systemFontOfSize:12.0];
		[self addSubview:holder];
		self.holderLabel = holder;
	}
	return self;
}
@end
