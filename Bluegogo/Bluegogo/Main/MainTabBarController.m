//
//  MainTabBarController.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupTabBar];
}
-(void)setupTabBar{
	YJHomeViewController *homeVC = [YJHomeViewController new];
	[self addChildViewController:homeVC WithImage:[UIImage imageNamed:@"Home.png"] selectedImage:[UIImage imageNamed:@"Home.png"] title:@"首页"];
	YJNewsViewController *newsVC = [YJNewsViewController new];
	[self addChildViewController:newsVC WithImage:[UIImage imageNamed:@"News.png"] selectedImage:[UIImage imageNamed:@"News.png"] title:@"新闻"];
	YJMyViewController *myVC = [YJMyViewController new];
	[self addChildViewController:myVC WithImage:[UIImage imageNamed:@"My.png"] selectedImage:[UIImage imageNamed:@"My.png"] title:@"个人"];
}
-(void)addChildViewController:(UIViewController *)controller WithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
	YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:controller];
	[nav.tabBarItem setImage:image];
	controller.title = title;
	nav.tabBarController.tabBar.tintColor = [UIColor redColor];
	[nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
	nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
	[self addChildViewController:nav];
}
@end
