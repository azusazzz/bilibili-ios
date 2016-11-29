//
//  RequestHandler.m
//  ESRequest
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RequestHandler.h"
#import <AFNetworking.h>
#import "ResponseSerializer.h"
#import "Request.h"

@interface RequestHandler ()

@property(strong, nonatomic, nonnull) AFHTTPSessionManager *HTTPSessionManager;

@end

@implementation RequestHandler



+ (RequestHandler *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:NULL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _HTTPSessionManager.responseSerializer = [ResponseSerializer serializer];
        [_HTTPSessionManager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
            return [[RequestHandler sharedInstance] queryStringSerialization:request parameters:parameters error:error];
        }];
    }
    return self;
}

- (NSURLSessionDataTask *)sendRequest:(Request *)request {
    return [self sendRequestWithURLString:request.URLString Method:request.method parameters:request.parameters delegate:request];
}

- (NSURLSessionDataTask *)sendRequestWithURLString:(NSString *)URLString Method:(HTTPMethod)method parameters:(id)parameters delegate:(id<RequestHandlerDelegate>)delegate {
    if (![URLString hasPrefix:@"http"]) {
        URLString = [_baseURLString stringByAppendingPathComponent:URLString];
    }
    if (method == HTTPMethodGet) {
        return [_HTTPSessionManager GET:URLString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [delegate requestHandlerResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [delegate requestHandlerError:error];
        }];
    }
    else if (method == HTTPMethodPost) {
        return [_HTTPSessionManager POST:URLString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [delegate requestHandlerResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [delegate requestHandlerError:error];
        }];
    }
    else {
        return NULL;
    }
}

#pragma mark get / set

- (NetworkReachabilityStatus)networkReachabilityStatus; {
    return (NetworkReachabilityStatus)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    _timeoutInterval = timeoutInterval;
    _HTTPSessionManager.requestSerializer.timeoutInterval = _timeoutInterval;
}


- (NSString *)queryStringSerialization:(NSURLRequest *)request parameters:(id)parameters error:(NSError *__autoreleasing *)error; {
    NSArray* (^parametersToArray)(NSDictionary *dictionary) = ^(NSDictionary *dictionary) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:dictionary.count];
        for (NSObject *key in dictionary.allKeys) {
            [array addObject:[NSString stringWithFormat:@"%@=%@", key, [dictionary objectForKey:key]]];
        }
        return [NSArray arrayWithArray:array];
    };
    
    NSString *(^parametersToString)(NSArray *array) = ^(NSArray *array) {
        return [array componentsJoinedByString:@"&"];
    };
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = parameters;
        if (dict.count == 0) {
            return NULL;
        }
        return parametersToString(parametersToArray(parameters));
    }
    else if ([parameters isKindOfClass:[NSArray class]]) {
        NSArray *array = parameters;
        if (array.count == 0) {
            return NULL;
        }
        return parametersToString(parameters);
    }
    else if ([parameters isKindOfClass:[NSString class]]) {
        return parameters;
    }
    else {
        return NULL;
    }
}


@end
