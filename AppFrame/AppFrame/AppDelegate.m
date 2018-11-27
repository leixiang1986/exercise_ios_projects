//
//  AppDelegate.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "CustomTabbarController.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "ViewControllerC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewControllerA *vcA = [[ViewControllerA alloc] init];
    vcA.title = @"vcA";
    ViewControllerB *vcB = [[ViewControllerB alloc] init];
    vcB.title = @"vcB";
    ViewControllerC *vcC = [[ViewControllerC alloc] init];
    vcC.title = @"vcC";
    
    
    NSArray *infos = @[@{kTabBarTitleKey:@"vcA",kTabBarDefaultImageKey:@"ic_activity_normal",kTabBarHighlightImageKey:@"ic_activity_hlight"},
                       @{kTabBarTitleKey:@"vcB",kTabBarDefaultImageKey:@"ic_health_normal",kTabBarHighlightImageKey:@"ic_health_hlight"},
                       @{kTabBarTitleKey:@"vcC",kTabBarDefaultImageKey:@"ic_myband_normal",kTabBarHighlightImageKey:@"ic_myband_hlight"}];
    
    CustomTabbarController *tabbarVC = [[CustomTabbarController alloc] initWithViewControllers:@[vcA,vcB,vcC] withTabBarInfos:infos];
    _window.rootViewController = [[CustomNavigationController alloc] initWithRootViewController:tabbarVC];
    [_window makeKeyAndVisible];
    
    return YES;
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
