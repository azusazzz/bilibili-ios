//
//  URLRouter.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  打开URL处理完成后的回调
 *
 *  @param result 返回数据
 */
typedef void (^URLRouterCompletion)(id _Nullable result);



@interface URLRouterParameters : NSObject

@property (strong, nonatomic, nonnull) NSString *URL;

@property (strong, nonatomic, nullable) NSDictionary *userInfo;

@property (copy, nonatomic, nullable) URLRouterCompletion completion;

@end


/**
 *  是否可以打开链接
 *
 *  @param URL
 */
typedef BOOL (^URLRouterCanOpenURL)(NSString * _Nonnull URL);
/**
 *  打开链接
 *
 *  @param routerParameters 参数
 */
typedef BOOL (^URLRouterHandler)(URLRouterParameters * _Nonnull routerParameters);



@protocol URLRouterProtocol <NSObject>

/**
 *  是否可以打开URL
 */
+ (BOOL)canOpenURL:(NSString * _Nonnull)URL;

/**
 *  打开URL
 */
+ (BOOL)openURLWithRouterParameters:(URLRouterParameters * _Nonnull)parameters;

@end


/**
 *  URL跳转路由
 */
@interface URLRouter : NSObject

#pragma mark Register 注册

+ (void)registerURLPattern:(NSString * _Nonnull)URLPattern toHandler:(URLRouterHandler _Nonnull)handler;

+ (void)registerClass:(Class<URLRouterProtocol> _Nonnull)cls;

+ (void)registerKey:(NSString * _Nonnull)key canOpenURL:(URLRouterCanOpenURL _Nonnull)canOpenURL toHandler:(URLRouterHandler _Nonnull)handler;

#pragma mark UnRegister 注销

+ (void)unregisterURLPattern:(NSString * _Nonnull)URLPattern;

+ (void)unregisterClass:(Class<URLRouterProtocol> _Nonnull)cls;

+ (void)unregisterWithKey:(NSString * _Nonnull)key;

#pragma mark OpenURL 打开URL

+ (BOOL)openURL:(NSString * _Nonnull)URL;

+ (BOOL)openURL:(NSString * _Nonnull)URL withUserInfo:(NSDictionary * _Nonnull)userInfo;

+ (BOOL)openURL:(NSString * _Nonnull)URL completion:(URLRouterCompletion _Nonnull)completion;

+ (BOOL)openURL:(NSString * _Nonnull)URL withUserInfo:(NSDictionary * _Nullable)userInfo completion:(URLRouterCompletion _Nullable)completion;


@end


