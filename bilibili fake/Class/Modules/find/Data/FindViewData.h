//
//  FindViewData.h
//  bilibili fake
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindViewData : NSObject

/**
 *  获取标签列表
 *
 *  @param block 返回标签数据
 */
+(void)getKeyword:(void(^)(NSMutableArray* keyword_arr))block;







/**
 *  获取搜索记录
 *
 *  @return 搜索记录数组
 */
+(NSMutableArray*)getSearchRecords;

/**
 *  设置搜索记录
 *
 *  @param arr 搜索记录数组
 */
+(void)setSearchRecords:(NSMutableArray*)arr;

/**
 *  清空搜索记录
 */
+(void)clearSearchRecords;

/**
 *  增加搜索记录
 *
 *  @param str 要增加的关键字
 */
+(void)addSearchRecords:(NSString*)str;


@end
