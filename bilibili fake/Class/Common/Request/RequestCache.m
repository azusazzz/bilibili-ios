//
//  RequestCache.m
//  ESRequest
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RequestCache.h"
#import "Request.h"

@implementation RequestCache

+ (RequestCache *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        _diskPath = [cachesDirectory stringByAppendingString:@"/RequestCache"];
        [[NSFileManager defaultManager] createDirectoryAtPath:_diskPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return self;
}


#pragma mark request

- (void)storeCachedJSONObjectForRequest:(Request *)request {
    NSData *cachedData = [NSJSONSerialization dataWithJSONObject:request.responseObject options:kNilOptions error:NULL];
    [self storeCachedData:cachedData ForPath:[self cachedPathForRequest:request]];
}

- (NSObject *)cachedJSONObjectForRequest:(Request *)request isTimeout:(BOOL *)isTimeout {
    NSData *cachedData = [self cachedDataForPath:[self cachedPathForRequest:request] TimeoutInterval:request.cacheTimeoutInterval IsTimeout:isTimeout];
    if (cachedData) {
        return [NSJSONSerialization JSONObjectWithData:cachedData options:kNilOptions error:NULL];
    }
    else {
        return NULL;
    }
}

- (void)removeCachedJSONObjectForRequest:(Request *)request {
    [self removeCachedDataForPath:[self cachedPathForRequest:request]];
}

- (NSString *)cachedPathForRequest:(Request *)request {
    return [NSString stringWithFormat:@"%@/%@/%@", _diskPath, request.groupName, request.identifier];
}

- (void)removeCacheForGroup:(NSString *)groupName {
    
}


#pragma mark path

- (void)storeCachedData:(NSData *)cachedData ForPath:(NSString *)path {
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

- (NSData *)cachedDataForPath:(NSString *)path TimeoutInterval:(NSTimeInterval)timeoutInterval IsTimeout:(BOOL *)isTimeout {
    if (![path length]) {
        return NULL;
    }
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

- (void)removeCachedDataForPath:(NSString *)path {
    if (![path length]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}



#pragma mark remove

- (void)removeAllCachedData {
    [[NSFileManager defaultManager] removeItemAtPath:_diskPath error:NULL];
}

@end
