//
//  AppDelegate.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "AppDelegate.h"

//
#import "ViewController.h"
#import "TestTabBarController.h"
//#import "ED_URLProtocol.h"
#import "ED_ContinueLocationManager.h"

#import "ED_CrashControl.h"

//

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [NSURLProtocol registerClass:[ED_URLProtocol class]];
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[TestTabBarController alloc] init];
//    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
//    [[ED_ContinueLocationManager shareInstance] startLocationIfAppKilled];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [[ED_ContinueLocationManager shareInstance] startLocationOutOfApp];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [ED_CrashControl beginListenCrash];
    
    
    
    NSLog(@"==================================== %ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"1077"]);

    NSArray *array = [[ED_ContinueLocationManager shareInstance]getLocationsFromLocalWithTimeSpace:120];
    NSLog(@"-------------------------------------%@",array);
    [[ED_ContinueLocationManager shareInstance] removeLocationsFromLocal];
    
    [[ED_ContinueLocationManager shareInstance] startLocationInApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
