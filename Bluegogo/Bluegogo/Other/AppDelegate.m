//
//  AppDelegate.m
//  Bluegogo
//
//  Created by 袁杰 on 2017/6/4.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "AppDelegate.h"
#import "YJLoginController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	[self mapConfig];
	[self weatherConfig];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	MainTabBarController *tabBarVC = [MainTabBarController new];
	self.window.rootViewController = tabBarVC;
	[self.window makeKeyAndVisible];
	
	NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
	if (!username) {
		YJLoginController *login = [YJLoginController new];
		YJNavigationController *navigation = [[YJNavigationController alloc] initWithRootViewController:login];
		navigation.navigationBar.hidden = YES;
		[self.window.rootViewController presentViewController:navigation animated:YES completion:nil];
	}
	return YES;
}
-(void)mapConfig
{
	[AMapServices sharedServices].apiKey = @"ad982a40bb4de9f2f08e2d53ddb5504a";
}
-(void)weatherConfig
{
	[[NSUserDefaults standardUserDefaults] setObject:@"912c238d118c4a1096880177a9aec6a0" forKey:@"weather_key"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
