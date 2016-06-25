//
//  ESAPIConfigManager.h
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGet,
    HTTPMethodPost,
};


typedef NSInteger APIType;


@interface ESAPIConfig : NSObject

@property (strong, nonatomic) NSString *URLString;

@property (assign, nonatomic) HTTPMethod method;

@property (assign, nonatomic) NSTimeInterval cacheTimeoutInterval;

+ (instancetype)APIConfigWithURLString:(NSString *)URLString Method:(HTTPMethod)method CacheTimeOut:(NSTimeInterval)cacheTimeOut;

@end



@interface ESAPIConfigManager : NSObject


@property (strong, nonatomic) NSString *baseURLString;


+ (ESAPIConfigManager *)sharedInstance;


- (ESAPIConfig *)APIConfigForType:(APIType)type;


#pragma mark 添加接口配置


- (void)addAPIType:(APIType)type withURLString:(NSString *)URLString Method:(HTTPMethod)method;

- (void)addAPIType:(APIType)type withURLString:(NSString *)URLString Method:(HTTPMethod)method CacheTimeoutInterval:(NSTimeInterval)cacheTimeoutInterval;

- (void)addAPIType:(APIType)type withConfig:(ESAPIConfig *)config;


@end

