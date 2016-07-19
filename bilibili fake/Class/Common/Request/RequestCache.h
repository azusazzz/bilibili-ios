//
//  RequestCache.h
//  ESRequest
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Request;

@interface RequestCache : NSObject

@property (strong, nonatomic) NSString *diskPath;

+ (RequestCache *)sharedInstance;


- (void)storeCachedJSONObjectForRequest:(Request *)request;

- (NSObject *)cachedJSONObjectForRequest:(Request *)request isTimeout:(BOOL *)isTimeout;

- (void)removeCachedJSONObjectForRequest:(Request *)request;


- (void)storeCachedData:(NSData *)cachedData ForPath:(NSString *)path;

- (NSData *)cachedDataForPath:(NSString *)path TimeoutInterval:(NSTimeInterval)timeoutInterval IsTimeout:(BOOL *)isTimeout;

- (void)removeCachedDataForPath:(NSString *)path;


- (void)removeAllCachedData;

@end
