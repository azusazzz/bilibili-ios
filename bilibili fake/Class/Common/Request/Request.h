//
//  Request.h
//  ESRequest
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RequestHandler.h"


@class Request;

@protocol RequestDelegate <NSObject>

@optional

- (void)requestCompletion:(Request *)request;

@end


@interface Request : NSObject
<RequestHandlerDelegate>


@property (strong, nonatomic) NSString *URLString;

@property (assign, nonatomic) HTTPMethod method;

@property (strong, nonatomic) NSObject *parameters;


#pragma mark Cache

@property (assign, nonatomic) NSTimeInterval cacheTimeoutInterval;

@property (strong, nonatomic) NSString *groupName;

@property (strong, nonatomic) NSString *identifier;



@property (assign, nonatomic) NSInteger tag;


@property (strong, nonatomic) NSURLSessionTask *task;

@property (readonly) NSURLSessionTaskState state;

@property (strong, nonatomic, readonly) id responseObject;

@property (strong, nonatomic, readonly) NSError *error;



@property (weak, nonatomic) id<RequestDelegate> delegate;

@property (copy, nonatomic) void (^completionBlock)(Request * request);


+ (instancetype)requestWithDelegate:(id<RequestDelegate>)delegate;

+ (instancetype)requestWithCompletionBlock:(void (^)(Request *request))completionBlock;


- (void)resume;

- (void)suspend;

- (void)cancel;






- (void)willResume __attribute__((objc_requires_super));

- (void)willReadCache __attribute__((objc_requires_super));

- (BOOL)didReadCache;

- (void)completed __attribute__((objc_requires_super));

- (void)success __attribute__((objc_requires_super));

- (void)failure __attribute__((objc_requires_super));

- (BOOL)willStoreCache;




@end
