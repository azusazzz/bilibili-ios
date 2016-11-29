//
//  RequestHandler.h
//  ESRequest
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGet,
    HTTPMethodPost,
};

typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};

@class Request;


@protocol RequestHandlerDelegate <NSObject>

- (void)requestHandlerResponseObject:(id)responseObject;

- (void)requestHandlerError:(NSError *)error;

@end




@interface RequestHandler : NSObject

@property (readonly, nonatomic, assign) NetworkReachabilityStatus networkReachabilityStatus;

@property (assign, nonatomic) NSTimeInterval timeoutInterval;

@property (strong, nonatomic) NSString *baseURLString;


+ (RequestHandler *)sharedInstance;


- (NSURLSessionDataTask *)sendRequest:(Request *)request;

- (NSURLSessionDataTask *)sendRequestWithURLString:(NSString *)URLString Method:(HTTPMethod)method parameters:(id)parameters delegate:(id<RequestHandlerDelegate>)delegate;


@end
