//
//  URLRouter.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "URLRouter.h"
#import "UIViewController+GetViewController.h"
#import "WebViewController.h"


@interface URLRoute : NSObject

@property (strong, nonatomic) NSString *key;

@property (strong, nonatomic) URLRouterCanOpenURL canOpenURL;

@property (strong, nonatomic) URLRouterHandler handler;

@end

@implementation URLRoute

+ (instancetype)routeWithKey:(NSString *)key canOpenURL:(URLRouterCanOpenURL)canOpenURL handler:(URLRouterHandler)handler {
    URLRoute *route = [[URLRoute alloc] init];
    route.key = key;
    route.canOpenURL = [canOpenURL copy];
    route.handler = [handler copy];
    return route;
}

@end

@implementation URLRouterParameters

+ (instancetype)parametersWithURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(URLRouterCompletion)completion {
    URLRouterParameters *parameters = [[URLRouterParameters alloc] init];
    parameters.URL = URL;
    parameters.userInfo = userInfo;
    parameters.completion = completion;
    return parameters;
}

@end


@interface URLRouter ()

@property (nonatomic, strong) NSMutableArray<URLRoute *> *routes;

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

- (instancetype)init {
    if (self = [super init]) {
        _routes = [NSMutableArray array];
    }
    return self;
}

#pragma mark Register 注册

+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(URLRouterHandler)handler {
    URLRouterCanOpenURL canOpenURL = ^BOOL(NSString *URL) {
        return [URL rangeOfString:URLPattern].length > 0;
    };
    [self registerKey:URLPattern canOpenURL:canOpenURL toHandler:handler];
}
+ (void)registerClass:(Class<URLRouterProtocol>)cls {
    URLRouterCanOpenURL canOpenURL = ^BOOL(NSString *URL) {
        return [cls canOpenURL:URL];;
    };
    URLRouterHandler handler = ^(URLRouterParameters * routerParameters) {
        return [cls openURLWithRouterParameters:routerParameters];
    };
    [self registerKey:NSStringFromClass(cls) canOpenURL:canOpenURL toHandler:handler];
}

+ (void)registerKey:(NSString *)key canOpenURL:(URLRouterCanOpenURL)canOpenURL toHandler:(URLRouterHandler)handler {
    for (URLRoute *route in [URLRouter sharedInstance].routes) {
        if ([route.key isEqualToString:key]) {
            route.canOpenURL = canOpenURL;
            route.handler = handler;
            return;
        }
    }
    [[URLRouter sharedInstance].routes addObject:[URLRoute routeWithKey:key canOpenURL:canOpenURL handler:handler]];
}

#pragma mark UnRegister 注销

+ (void)unregisterURLPattern:(NSString *)URLPattern {
    [self unregisterWithKey:URLPattern];
}
+ (void)unregisterClass:(Class<URLRouterProtocol>)cls {
    [self unregisterWithKey:NSStringFromClass(cls)];
}
+ (void)unregisterWithKey:(NSString *)key {
    [[URLRouter sharedInstance].routes enumerateObjectsUsingBlock:^(URLRoute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.key isEqualToString:key]) {
            [[URLRouter sharedInstance].routes removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
}

#pragma mark OpenURL 打开URL

+ (BOOL)openURL:(NSString *)URL {
    return [self openURL:URL withUserInfo:NULL completion:NULL];
}
+ (BOOL)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo {
    return [self openURL:URL withUserInfo:userInfo completion:NULL];
}
+ (BOOL)openURL:(NSString *)URL completion:(URLRouterCompletion)completion {
    return [self openURL:URL withUserInfo:NULL completion:completion];
}
+ (BOOL)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(URLRouterCompletion)completion {
    for (URLRoute *route in [URLRouter sharedInstance].routes) {
        if (route.canOpenURL(URL)) {
            URLRouterParameters *parameters = [URLRouterParameters parametersWithURL:URL withUserInfo:userInfo completion:completion];
            if (route.handler(parameters)) {
                return YES;
            }
        }
    }
    return NO;
}




@end


