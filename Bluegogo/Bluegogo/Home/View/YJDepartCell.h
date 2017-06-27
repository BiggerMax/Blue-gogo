//
//  YJDepartCell.h
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/26.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DepartCellDelegate <NSObject>

-(void)callNumber:(NSString *)tel;
-(void)naviForIndex:(NSUInteger)index;
-(void)date;

@end
@interface YJDepartCell : UITableViewCell
@property(nonatomic,weak)id <DepartCellDelegate>delegate;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UIView *datingBtn;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, assign) NSUInteger index;
@end
