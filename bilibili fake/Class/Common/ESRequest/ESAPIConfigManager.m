//
//  ESAPIConfigManager.m
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ESAPIConfigManager.h"

@implementation ESAPIConfig

+ (instancetype)APIConfigWithURLString:(NSString *)URLString Method:(HTTPMethod)method CacheTimeOut:(NSTimeInterval)cacheTimeOut;
{
    ESAPIConfig *api = [[ESAPIConfig alloc] init];
    api.URLString = URLString;
    api.method = method;
    api.cacheTimeoutInterval = cacheTimeOut;
    return api;
}

@end




@interface ESAPIConfigManager ()
{
    NSMutableDictionary<NSNumber *, ESAPIConfig *> *_APIConfigs;
}
@end

@implementation ESAPIConfigManager

+ (nonnull ESAPIConfigManager *)sharedInstance;
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (ESAPIConfig *)APIConfigForType:(APIType)type;
{
    return [_APIConfigs objectForKey:@(type)];
}


#pragma mark 添加接口配置

- (void)addAPIType:(APIType)type withURLString:(NSString *)URLString Method:(HTTPMethod)method;
{
    [self addAPIType:type withURLString:URLString Method:method CacheTimeoutInterval:0];
}

- (void)addAPIType:(APIType)type withURLString:(NSString *)URLString Method:(HTTPMethod)method CacheTimeoutInterval:(NSTimeInterval)cacheTimeoutInterval;
{
    [self addAPIType:type withConfig:[ESAPIConfig APIConfigWithURLString:URLString Method:method CacheTimeOut:cacheTimeoutInterval]];
}

- (void)addAPIType:(APIType)type withConfig:(ESAPIConfig *)config;
{
    if (!_APIConfigs) {
        _APIConfigs = [NSMutableDictionary dictionary];
    }
    [_APIConfigs setObject:config forKey:@(type)];
}

@end
