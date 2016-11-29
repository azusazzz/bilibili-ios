//
//  RecommendListModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecommendEntity.h"


@interface RecommendListModel : NSObject

@property (strong, nonatomic) NSArray<RecommendEntity *> *recommendList;

- (void)getRecommendListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;



@end
