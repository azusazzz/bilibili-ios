//
//  ESRequest.h
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ESRequest.
FOUNDATION_EXPORT double ESRequestVersionNumber;

//! Project version string for ESRequest.
FOUNDATION_EXPORT const unsigned char ESRequestVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ESRequest/PublicHeader.h>

#import "ESRequestHandler.h"
#import "ESRequestCache.h"
#import "ESAPIConfigManager.h"


typedef NS_ENUM(NSInteger, ESRequestModel) {
    /**
     *  默认
     */
    ESRequestModelDefault = 0,
    /**
     *  只从网络获取数据
     */
    ESRequestModelNetwork = 1,
    /**
     *  只从缓存获取数据
     */
    ESRequestModelCache = 2,
};

@protocol ESRequestDelegate <NSObject>

@optional
- (void)requestCompletion:(ESRequest *)request;

- (void)willStartRequest:(ESRequest *)request;

@end




@interface ESRequest : NSObject
<ESRequestHandlerDelegate>

#pragma mark Config

@property (assign, nonatomic, readonly) APIType type;

@property (strong, nonatomic, readonly) NSString *URLString;

@property (assign, nonatomic, readonly) HTTPMethod method;

@property (assign, nonatomic, readonly) NSTimeInterval cacheTimeoutInterval;

@property (strong, nonatomic) NSObject *parameters;


#pragma mark Other

@property (strong, nonatomic, readonly) NSString *identifier;

@property (assign, nonatomic) NSInteger tag;

@property (assign, nonatomic, getter=isEexecuting, readonly) BOOL executing;

@property (assign, nonatomic, getter=isDataFromNetwork) BOOL dataFromNetwork;


#pragma mark Response


@property (strong, nonatomic, readonly) id responseObject;

@property (strong, nonatomic, readonly) NSError *error;

@property (assign, nonatomic, readonly) NSInteger responseStatusCode;

@property (strong, nonatomic, readonly) NSString *responseMsg;


#pragma mark 回调

@property (weak, nonatomic) id<ESRequestDelegate> delegate;

@property (copy, nonatomic) void (^completionBlock)(ESRequest * request);

@property (copy, nonatomic) void (^successCompletionBlock)(ESRequest * request);

@property (copy, nonatomic) void (^failureCompletionBlock)(ESRequest * request);


#pragma mark 提示框

@property (strong, nonatomic) UIView *hudSuperView;


#pragma mark 初始化

- (instancetype)initWithAPIType:(APIType)type;

+ (instancetype)RequestWithAPIType:(APIType)type parameters:(id)parameters delegate:(id<ESRequestDelegate>)delegate;



+ (instancetype)requestWithDelegate:(id<ESRequestDelegate>)delegate;

+ (instancetype)requestWithCompletionBlock:(void (^)(ESRequest * request))completionBlock;




#pragma mark 启动/停止

/**
 *  发送网络请求
 */
- (void)start;

/**
 *  取消网络请求结束后的回调
 */
- (void)stop;


#pragma mark 数据分页的请求

@property (assign, nonatomic) NSInteger index;

@property (assign, nonatomic) NSInteger pageSize;

@property (assign, nonatomic, readonly) BOOL next;

@property (strong, nonatomic) NSArray<NSString *> *nextKeyPath;

/**
 *  加载下一页数据
 */
- (void)nextPage;


#pragma mark --------

/**
 *  动态URLString
 *  URLString = /api/page/module/%%id%% | parameters = @{@"id":@10}  -->  URLString = /api/page/module/10 | parameters = @{}
 *
 *  @param callback 处理结果回调
 */
- (void)dynamicURLStringWithCallback:(void (^)(NSString *URLString, id parameters))callback;

/**
 *  将要发送网络请求
 */
- (void)willStartRequest;

/**
 *  将要读取缓存
 *
 *  @return 是否读取
 */
- (BOOL)willReadCache;

/**
 *  请求结束
 */
- (void)completion;

/**
 *  请求成功
 */
- (void)successCompletion;

/**
 *  请求失败
 */
- (void)failureCompletion;

/**
 *  将要缓存数据
 *
 *  @return 是否缓存
 */
- (BOOL)willStoreCache;

@end
