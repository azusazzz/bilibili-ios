//
//  AppDelegate.m
//  bilibili fake
//
//  Created by 翟泉 on 16/6/16.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AppDelegate.h"
#import <SDImageCache.h>

#import "StartView.h"
#import "ScrollTabBarController.h"
#import "DanmakuRequest.h"


#import "VideoURL.h"

#import "DownloadManager.h"


#import "BaseRequest.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ScrollTabBarController alloc] init];
   
    [self.window makeKeyAndVisible];
    [StartView show];
    
    
    
//    DownloadOperation *operation = [[DownloadManager manager] operationWithAid:3743027 cid:6001707 page:1];
//    [operation setProgressChanged:^(DownloadOperation * _Nonnull operation) {
//        NSLog(@"%lf", operation.countOfBytesReceived / (CGFloat)operation.countOfBytesExpectedToReceive);
//    }];
//    [operation setStatusChanged:^(DownloadOperation * _Nonnull operation) {
//        NSLog(@"%ld", operation.status);
//    }];
//    [operation resume];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
