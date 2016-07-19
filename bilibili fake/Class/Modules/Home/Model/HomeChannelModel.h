//
//  HomeChannelModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeChannelEntity.h"

@interface HomeChannelModel : NSObject


@property (strong, nonatomic) NSArray<HomeChannelEntity *> *entitys;

/**
 *  获取分区页面的数据
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)getChannelDataWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
