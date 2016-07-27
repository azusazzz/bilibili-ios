//
//  HomeRecommendModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeRecommendEntity.h"

@interface HomeRecommendModel : NSObject

@property (strong, nonatomic) NSArray<HomeRecommendEntity *> *recommendList;

- (void)getRecommendListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
