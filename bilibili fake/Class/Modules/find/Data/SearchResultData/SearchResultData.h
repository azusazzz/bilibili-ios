//
//  SearchResultData.h
//  bilibili fake
//
//  Created by cxh on 16/7/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultData : NSObject
/**
 *  增加搜索记录
 *
 *  @param str 要增加的关键字
 */
+(void)addSearchRecords:(NSString*)str;



//--------------------------------------------------------------



//初始化
-(instancetype)initWithKeyword:(NSString*)keyword;
//设置keyword 获取数据前必须要设置关键字
-(void)setKeyword:(NSString*)keyword;


//获取页眉信息
-(void)getPageinfo:(void(^)(NSInteger bangumiCount,NSInteger specialCount,NSInteger upuserCount))successBlock;


/**
 * 获取up主,番剧,信息
 *
 *  @param search_type  搜索类型
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
-(void)getNonVideoSearchResultData_arr:(NSString* )search_type Success:(void(^)(NSMutableArray* SearchResultData_arr))successBlock Error:(void(^)(NSError* error))errorBlock;


/**
 *  获取更多的up主,番剧,信息
 *
 *  @param search_type  搜索类型
 *  @param successBlock 成功回调（回调所有的结果）
 */
-(void)getMoreNonVideoSearchResultData_arr:(NSString* )search_type Success:(void(^)(NSMutableArray* UpuserSearchResultData_arr))successBlock;




/**
 *  获取视频搜索结果
 *
 *  @param order        排序方式
 *  @param name         tid对应的名字
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
-(void)getVideoSearchResultData_arr:(NSString* )order Tid_name:(NSString*)name Success:(void(^)(NSMutableArray* SearchResultData_arr, NSMutableArray* bangumiSearchResultData_arr))successBlock Error:(void(^)(NSError* error))errorBlock;
/**
 *  获取视频搜索结果
 *
 *  @param order        排序方式
 *  @param name         tid对应的名字
 *  @param successBlock 成功回调
 */
-(void)getMoreVideoSearchResultData_arr:(NSString* )order Tid_name:(NSString*)name Success:(void(^)(NSMutableArray* SearchResultData_arr))successBlock;

@end
