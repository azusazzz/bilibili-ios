//
//  BangumiListModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BangumiListEntity.h"

@interface BangumiListModel : NSObject

@property (strong, nonatomic) BangumiListEntity *bangumiList;

- (void)getBangumiListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
