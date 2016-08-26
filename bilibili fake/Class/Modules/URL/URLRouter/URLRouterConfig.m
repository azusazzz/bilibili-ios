//
//  URLRouterConfig.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/26.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "URLRouter.h"

#import "UIViewController+GetViewController.h"

#import "WebViewController.h"
#import "VideoViewController.h"

__attribute__((constructor))
static void beforeMain(void) {
    NSLog(@"beforeMain");
    
    
    [URLRouter registerClass:[VideoViewController class]];
    
    // http://bangumi.bilibili.com/mobile/anime/5469
    
    
    
    [URLRouter registerKey:@"WebView" canOpenURL:^BOOL(NSString * _Nonnull URL) {
        if ([[UIViewController currentViewController] isKindOfClass:[WebViewController class]]) {
            return NO;
        }
        return [URL hasPrefix:@"http"];
    } toHandler:^(URLRouterParameters * _Nonnull routerParameters) {
        
        WebViewController *controller = [[WebViewController alloc] initWithURL:routerParameters.URL];
        [[UIViewController currentNavigationViewController] pushViewController:controller animated:YES];
        return YES;
    }];
    
}

__attribute__((destructor))
static void afterMain(void) {
    NSLog(@"afterMain");
}


