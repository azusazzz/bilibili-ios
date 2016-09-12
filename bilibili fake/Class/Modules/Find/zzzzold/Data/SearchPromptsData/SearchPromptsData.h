//
//  SearchAlertData.h
//  bilibili fake
//
//  Created by cxh on 16/7/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchPromptsData : NSObject
/**
 *  获取搜索记录
 *
 *  @return 搜索记录数组
 */
+(NSMutableArray*)getSearchRecords;


/**
 *  清空搜索记录
 */
+(void)clearSearchRecords;

/**
 *  搜索关键字补全
 *
 *  @param keywork 关键字
 *  @param block   返回提示
 */
+(void)getSearchPrompts:(NSString*)keywork Block:(void(^)(NSMutableArray* Prompts))block;

+(void)clear;
@end
