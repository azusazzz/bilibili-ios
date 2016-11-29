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

#import "HomeViewController.h"

#import "BangumiInfoViewController.h" // 番剧详情

/**
 *  +load之后 main函数之前 被调用
 */
__attribute__((constructor))
static void URLRouterConfig(void) {
    
    /**
     *  视频信息
     */
    // http://www.bilibili.com/video/av2344701/
    // bilibili://video/6002357
    // http://www.bilibili.com/mobile/video/av5104768.html
    [URLRouter registerClass:[VideoViewController class]];
    
    
    // 分区-直播  --> 首页-直播
    [URLRouter registerURLPattern:@"bilibili://home/live" toHandler:^BOOL(URLRouterParameters * _Nonnull routerParameters) {
        [HomeViewController showLiveList];
        return YES;
    }];
    
    
    /**
     *  番剧信息
     */
    // http://bangumi.bilibili.com/mobile/anime/5469
    // bilibili://bangumi/season/5047
    // http://bangumi.bilibili.com/anime/5029
    [URLRouter registerKey:@"bangumi" canOpenURL:^BOOL(NSString * _Nonnull URL) {
        //
        return [URL hasPrefix:@"bilibili://bangumi/season/"] ||
        [URL hasPrefix:@"http://bangumi.bilibili.com/mobile/anime/"] ||
        [URL hasPrefix:@"http://bangumi.bilibili.com/anime/"];
    } toHandler:^BOOL(URLRouterParameters * _Nonnull routerParameters) {
        NSInteger seasonId = [[routerParameters.URL lastPathComponent] integerValue];
        if (seasonId <= 0) {
            return NO;
        }
        [[UIViewController currentNavigationViewController] pushViewController:[[BangumiInfoViewController alloc] initWithID:seasonId] animated:YES];
        return YES;
    }];
    
    
    /**
     *  网页
     */
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

