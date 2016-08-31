//
//  RegionShowRecommendModel.h
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionShowRecommendEntity.h"

@interface RegionShowRecommendModel : NSObject

@property (strong, nonatomic, readonly) RegionShowRecommendEntity *regionShow;

- (instancetype)initWithRid:(NSInteger)rid;

- (void)getRegionShowWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
