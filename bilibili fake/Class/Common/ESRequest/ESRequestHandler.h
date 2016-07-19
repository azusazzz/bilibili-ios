//
//  ESRequestHandler.h
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};

@class ESRequest;


@protocol ESRequestHandlerDelegate <NSObject>

- (void)requestHandlerResponseObject:(id)responseObject error:(NSError *)error;

@end

/**
 *  请求处理
 */
@interface ESRequestHandler : NSObject

/**
 *  网络状态
 */
@property (readonly, nonatomic, assign) NetworkReachabilityStatus networkReachabilityStatus;

/**
 *  请求超时时间
 */
@property (assign, nonatomic) NSTimeInterval requestTimeoutInterval;

@property (strong, nonatomic) NSString *baseURLString;



/**
 *  共享实例对象
 *
 *  @return <#return value description#>
 */
+ (ESRequestHandler *)sharedInstance;


/**
 *  发送网络请求
 *
 *  @param request 请求对象
 */
- (void)sendRequest:(ESRequest *)request;

@end
