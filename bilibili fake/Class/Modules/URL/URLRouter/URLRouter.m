//
//  URLRouter.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "URLRouter.h"
#import "WebViewController.h"
#import "UIViewController+GetViewController.h"

@interface URLRouter ()
{
    NSMutableDictionary *URLPatterns;
}
@end

@implementation URLRouter

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)openURL:(NSString *)URL {
    [[URLRouter sharedInstance] openURL:URL];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return NULL;
    }
    
    URLPatterns = [NSMutableDictionary dictionary];
    
    return self;
}

- (void)registerURLPattern:(NSString *)URLPattern toController:(UIViewController<URLRouterProtocol> *)controller {
    
    if (![controller respondsToSelector:@selector(initWithURL:)]) {
        return;
    }
    
    [URLPatterns setObject:NSStringFromClass([controller class]) forKey:URLPatterns];
    
}

- (void)openURL:(NSString *)URL {
    if ([URL hasPrefix:@"http"]) {
        WebViewController *controller = [[WebViewController alloc] initWithURL:URL];
        [[UIViewController currentNavigationViewController] pushViewController:controller animated:YES];
    }
}

@end
