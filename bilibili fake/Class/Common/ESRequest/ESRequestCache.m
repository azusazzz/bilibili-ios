//
//  ESRequestCache.m
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ESRequestCache.h"
#import "ESRequest.h"

@interface ESRequestCache ()
{
    NSMutableDictionary *_memoryCaches;
}

@end

@implementation ESRequestCache

+ (nonnull ESRequestCache *)sharedInstance;
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init;
{
    if (self = [super init]) {
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        _diskPath = [documentsPath stringByAppendingString:@"/RequestCache"];
        // 创建文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:_diskPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return self;
}


#pragma mark 缓存-Request

- (NSString *)cachedPathForRequest:(ESRequest *)request;
{
    return [NSString stringWithFormat:@"%@/%ld/%@", _diskPath, request.type, request.identifier];
}

- (void)storeCachedJSONObjectForRequest:(ESRequest *)request;
{
    NSData *cachedData = [NSJSONSerialization dataWithJSONObject:request.responseObject options:kNilOptions error:NULL];
    [self storeCachedData:cachedData ForPath:[self cachedPathForRequest:request]];
}

- (NSObject *)cachedJSONObjectForRequest:(ESRequest *)request IsTimeout:(BOOL *)isTimeout;
{
    NSData *cachedData = [self cachedDataForPath:[self cachedPathForRequest:request] TimeoutInterval:request.cacheTimeoutInterval IsTimeout:isTimeout];
    if (cachedData) {
        return [NSJSONSerialization JSONObjectWithData:cachedData options:kNilOptions error:NULL];
    }
    else {
        return NULL;
    }
}

- (void)removeCachedJSONObjectForRequest:(ESRequest *)request;
{
    [self removeCachedDataForPath:[self cachedPathForRequest:request]];
}

- (void)removeCachedJSONObjectForAPIType:(APIType)type;
{
    [self removeCachedDataForPath:[NSString stringWithFormat:@"%@/%ld", _diskPath, type]];
}

#pragma mark 缓存-Path

- (void)storeCachedData:(NSData *)cachedData ForPath:(NSString *)path;
{
    if (cachedData == NULL) {
        [self removeCachedDataForPath:path];
        return;
    }
    
    NSString *directoryPath = [path stringByDeletingLastPathComponent];
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isDirectory) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:NULL error:NULL];
    }
    [cachedData writeToFile:path atomically:YES];
}

- (NSData *)cachedDataForPath:(NSString *)path TimeoutInterval:(NSTimeInterval)timeoutInterval IsTimeout:(BOOL *)isTimeout;
{
    NSData *cachedData = [[NSData alloc] initWithContentsOfFile:path];
    
    if (!cachedData) {
        return NULL;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] fileAttributesAtPath:path traverseLink:true];
#pragma clang diagnostic pop
    NSDate *fileModificationDate = [fileAttributes valueForKey:NSFileModificationDate];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:fileModificationDate];
    *isTimeout = (timeInterval > timeoutInterval);
    
    return cachedData;
}

- (void)removeCachedDataForPath:(NSString *)path;
{
    if (![path length]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}


#pragma mark 移除所有缓存

- (void)removeAllMemoryCachedData;
{
    [_memoryCaches removeAllObjects];
}

- (void)removeAllDiskCachedData;
{
    [[NSFileManager defaultManager] removeItemAtPath:_diskPath error:NULL];
}

- (void)removeAllCachedData;
{
    [self removeAllMemoryCachedData];
    [self removeAllDiskCachedData];
}


@end

