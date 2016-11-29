//
//  HistoryModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryEntity.h"


@interface HistoryModel : NSObject


@property (strong, nonatomic) NSArray<HistoryEntity *> *list;

/**
 *  新增历史记录
 *
 *  @param history <#history description#>
 */
+ (void)addHistory:(HistoryEntity *)history;

/**
 *  清空播放历史记录
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)deleteAllHistoryWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


/**
 *  获取历史记录列表
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getHistoryListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


/**
 *  删除播放历史记录
 *
 *  @param aid     <#aid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)deleteHistoryWithAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
