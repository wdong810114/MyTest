//
//  AppDelegate.m
//  Test001
//
//  Created by wangdongdong on 16/3/14.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
//    self.window.layer.speed = 0.5;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

#pragma mark - Getter
- (UINavigationController *)navigationController
{
    if(!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    }
    
    return _navigationController;
}

@end
