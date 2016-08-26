//
//  WebViewCache.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "WebViewCache.h"
#import "NSString+MD5.h"


static NSString *URLProtocolHandledKey = @"WebViewURLHasHandle";
static NSTimeInterval CacheTimeout = 60 * 60 * 24 * 7;
static NSString *WebViewCachesDirectory;


@interface WebViewCache ()
<NSURLConnectionDelegate>

@property (strong, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) NSMutableData *mutableData;

@end

@implementation WebViewCache

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSURLProtocol registerClass:[WebViewCache class]];
    });
}

+ (void)removeAllCache {
    if (!WebViewCachesDirectory) {
        NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        WebViewCachesDirectory = [NSString stringWithFormat:@"%@/WebView", cachesDirectory];
    }
    [[NSFileManager defaultManager] removeItemAtPath:WebViewCachesDirectory error:NULL];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([request.URL.absoluteString rangeOfString:@".png"].length || [request.URL.absoluteString rangeOfString:@".jpg"].length) {
        if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
    
    NSData *data = [self cacheForRequest:self.request];
    if (data) {
        printf("Cache\t%s\n", [self.request.URL.absoluteString cStringUsingEncoding:NSUTF8StringEncoding]);
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[self.request.URL copy] MIMEType:@"image/*" expectedContentLength:data.length textEncodingName:NULL];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else {
        _mutableData = [NSMutableData data];
        _connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
    }
}

- (void)stopLoading {
    [_connection cancel];
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data {
    [_mutableData appendBytes:data.bytes length:data.length];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    printf("Network\t%s\n", [self.request.URL.absoluteString cStringUsingEncoding:NSUTF8StringEncoding]);
    NSData *data = _mutableData;
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
    [self storeCache:data atRequest:self.request];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}


#pragma mark - Tool

- (NSData *)cacheForRequest:(NSURLRequest *)request {
    NSString *path = [self cachePathWithRequest:request];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] fileAttributesAtPath:path traverseLink:true];
#pragma clang diagnostic pop
    if (!fileAttributes) {
        return NULL;
    }
    NSDate *fileModificationDate = [fileAttributes valueForKey:NSFileModificationDate];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:fileModificationDate];
    if (timeInterval > CacheTimeout) {
        // 缓存时间超时
        return NULL;
    }
    return [NSData dataWithContentsOfFile:path];
}

- (NSString *)cachePathWithRequest:(NSURLRequest *)request {
    if (!WebViewCachesDirectory) {
        NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        WebViewCachesDirectory = [NSString stringWithFormat:@"%@/WebView", cachesDirectory];
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:WebViewCachesDirectory isDirectory:&isDirectory];
        if (!isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:WebViewCachesDirectory withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
    }
    NSString *urlString = self.request.URL.absoluteString;
    return [NSString stringWithFormat:@"%@/%@", WebViewCachesDirectory, urlString.MD5];
}

- (void)storeCache:(NSData *)cache atRequest:(NSURLRequest *)request {
    [cache writeToFile:[self cachePathWithRequest:request] atomically:YES];
}


@end
