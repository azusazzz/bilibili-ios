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












@end
