//
//  ESRequestHandler.m
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ESRequestHandler.h"
#import "ESRequest.h"
#import <AFNetworking.h>


@interface ESRequestHandler ()
{
    NetworkReachabilityStatus _networkReachabilityStatus;
}

@property(strong, nonatomic, nonnull) AFHTTPSessionManager *HTTPSessionManager;

@end

@implementation ESRequestHandler

@synthesize networkReachabilityStatus;

+ (nonnull ESRequestHandler *)sharedInstance;
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
        self.HTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:NULL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        self.HTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        
        [self.HTTPSessionManager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
            return [[ESRequestHandler sharedInstance] queryStringSerialization:request parameters:parameters error:error];
        }];
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _networkReachabilityStatus = (NetworkReachabilityStatus)status;
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        self.requestTimeoutInterval = 20;
        
        _baseURLString = @"";
    }
    return self;
}

- (NetworkReachabilityStatus)networkReachabilityStatus;
{
    return _networkReachabilityStatus;
}

- (void)setRequestTimeoutInterval:(NSTimeInterval)requestTimeoutInterval; {
    _requestTimeoutInterval = requestTimeoutInterval;
    self.HTTPSessionManager.requestSerializer.timeoutInterval = _requestTimeoutInterval;
}


#pragma mark query

- (NSString *)queryStringSerialization:(NSURLRequest *)request parameters:(id)parameters error:(NSError *__autoreleasing *)error;
{
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


#pragma mark sendRequst

- (void)sendRequest:(ESRequest *)request;
{
    __block NSString *URLString;
    __block id parameters;
    [request dynamicURLStringWithCallback:^(NSString *_URLString, id _parameters) {
        URLString = _URLString;
        parameters = _parameters;
    }];
    
    if ([URLString rangeOfString:@"http"].length == 0) {
        URLString = [_baseURLString stringByAppendingPathComponent:URLString];
    }
    
    if (request.method == HTTPMethodGet) {
        [self.HTTPSessionManager GET:URLString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            [request requestHandlerResponseObject:responseObject error:NULL];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //
            [request requestHandlerResponseObject:NULL error:error];
        }];
    }
    else if (request.method == HTTPMethodPost) {
        [self.HTTPSessionManager POST:URLString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //
            [request requestHandlerResponseObject:responseObject error:NULL];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //
            [request requestHandlerResponseObject:NULL error:error];
        }];
    }
}




@end
