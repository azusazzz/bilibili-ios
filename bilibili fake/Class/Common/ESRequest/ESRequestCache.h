//
//  ESRequestCache.h
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESAPIConfigManager.h"

@class ESRequest;


@interface ESRequestCache : NSObject

/**
 *  单位KB
 */
@property (assign, nonatomic) NSUInteger memoryCapacity;

/**
 *  单位KB
 */
@property (assign, nonatomic) NSUInteger diskCapacity;

/**
 *  当前使用的内存 KB
 */
@property (assign, nonatomic, readonly) NSUInteger currentMemoryUsage;

/**
 *  当前使用的硬盘空间 KB
 */
@property (assign, nonatomic, readonly) NSUInteger currentDiskUsage;

/**
 *  文件缓存路径
 */
@property (strong, nonatomic) NSString *diskPath;


+ (ESRequestCache *)sharedInstance;


#pragma mark 缓存-Request

/**
 *  存储网络请求的返回JSON对象
 *
 *  @param request 网络请求对象
 */
- (void)storeCachedJSONObjectForRequest:(ESRequest *)request;

/**
 *  读取网络请求的缓存数据
 *
 *  @param request   网络请求对象
 *  @param isTimeout 缓存数据是否超时
 *
 *  @return 缓存的JSON对象
 */
- (NSObject *)cachedJSONObjectForRequest:(ESRequest *)request IsTimeout:(BOOL *)isTimeout;

/**
 *  移除网络请求的缓存数据
 *
 *  @param request 网络请求对象
 */
- (void)removeCachedJSONObjectForRequest:(ESRequest *)request;

/**
 *  移除网络请求的缓存数据
 *
 *  @param type APIType
 */
- (void)removeCachedJSONObjectForAPIType:(APIType)type;

#pragma mark 缓存-路径

/**
 *  存储缓存数据
 *
 *  @param cachedData 缓存数据
 *  @param path       缓存路径
 */
- (void)storeCachedData:(NSData *)cachedData ForPath:(NSString *)path;

/**
 *  读取缓存数据
 *
 *  @param path            缓存路径
 *  @param timeoutInterval 缓存超时时间
 *  @param isTimeout       缓存是否超时
 *
 *  @return 缓存数据
 */
- (NSData *)cachedDataForPath:(NSString *)path TimeoutInterval:(NSTimeInterval)timeoutInterval IsTimeout:(BOOL *)isTimeout;

/**
 *  移除缓存
 *
 *  @param path 缓存路径
 */
- (void)removeCachedDataForPath:(NSString *)path;


#pragma mark 移除所有缓存

/**
 *  移除内存缓存
 */
- (void)removeAllMemoryCachedData;
/**
 *  移除硬盘缓存
 */
- (void)removeAllDiskCachedData;
/**
 *  移除所有缓存
 */
- (void)removeAllCachedData;


@end



