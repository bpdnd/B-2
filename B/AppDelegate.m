//
//  AppDelegate.m
//  B
//
//  Created by Admin on 2018/11/21.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "PlayListViewController.h"
#import "RecordViewController.h"
#import <Bugly/Bugly.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //播放
    PlayListViewController *playVC = [[PlayListViewController alloc]init];
    UINavigationController *playNav = [[UINavigationController alloc]initWithRootViewController:playVC];
    playNav.tabBarItem.image = [UIImage imageNamed:@"icon_playTabbar"];
    playNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_playTabbarSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    playNav.title = @"播放";
    //录制
    RecordViewController *recordVC = [[RecordViewController alloc]init];
    UINavigationController *recordNav = [[UINavigationController alloc]initWithRootViewController:recordVC];
    recordNav.tabBarItem.image = [UIImage imageNamed:@"icon_recordTabbar"];
    recordNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_recordTabbarSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    recordNav.title = @"录制";
    
    UITabBarController *tabbar = [[UITabBarController alloc]init];
    tabbar.viewControllers = @[playNav,recordNav];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    return YES;
}
#pragma 注册第三方
-(void)registerThird{
    //腾讯bugly
    [Bugly startWithAppId:@"d9e2f966c5"];
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
