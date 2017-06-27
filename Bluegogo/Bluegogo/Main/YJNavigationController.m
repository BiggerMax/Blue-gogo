//
//  YJNavigationController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJNavigationController.h"

@interface YJNavigationController ()

@end

@implementation YJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	NSMutableDictionary *dict = [NSMutableDictionary new];
	dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
	dict[NSForegroundColorAttributeName] = [UIColor blackColor];
	[self.navigationBar setTitleTextAttributes:dict];
	[self.navigationBar setBarTintColor:NAVBLUECOLOR];
	
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (self.childViewControllers.count > 0) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
		[button setImage:[UIImage imageNamed:@"navBarBack"] forState:UIControlStateNormal];
		[button setImage:[UIImage imageNamed:@"highlightBack"] forState:UIControlStateHighlighted];
		button.frame = CGRectMake(0, 0, 30, 30);
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
		
		viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
		viewController.hidesBottomBarWhenPushed = TRUE;
	}
	[super pushViewController:viewController animated:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

-(void)back{
	[self popViewControllerAnimated:YES];
}
@end
