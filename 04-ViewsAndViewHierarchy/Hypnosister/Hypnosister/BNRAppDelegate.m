//
//  BNRAppDelegate.m
//  Hypnosister
//
//  Created by John Gallagher on 1/6/14.
//  Copyright (c) 2014 John Gallagher. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRHypnosisView.h"

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	///< UIWindow 对象就像是一个容器，负责包含应用程序中的所有视图。在程序启动时创建并设置UIWindow,然后为其添加子视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    CGRect firstFrame = self.window.bounds;

	firstFrame = CGRectMake(200, 440, 100, 150);
    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:firstFrame];
	firstView.bDraw = NO;
	firstView.backgroundColor = [UIColor redColor];
    //[self.window addSubview:firstView];
	
	firstFrame = CGRectMake(20, 30, 50, 50);
	BNRHypnosisView *secondView = [[BNRHypnosisView alloc] initWithFrame:firstFrame];
	secondView.bDraw = NO;
	secondView.backgroundColor = [UIColor blueColor];
	[firstView addSubview:secondView];
	
	firstFrame = CGRectMake(20, 30, 50, 50);
	firstFrame = self.window.bounds;
	BNRHypnosisView *thirdView = [[BNRHypnosisView alloc] initWithFrame:firstFrame];
	thirdView.bDraw = YES;
	thirdView.backgroundColor = [UIColor blueColor];
	[self.window addSubview:thirdView];
	[self.window addSubview:firstView];
	
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
