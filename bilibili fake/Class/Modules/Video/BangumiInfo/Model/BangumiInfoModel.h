//
//  BangumiInfoModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiInfoEntity.h"

@interface BangumiInfoModel : NSObject

@property (assign, nonatomic, readonly) NSInteger ID;

@property (strong, nonatomic) BangumiInfoEntity *bangumiInfo;


- (instancetype)initWithID:(NSInteger)ID;

/**
 *  获取番剧信息
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getBangumiInfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
