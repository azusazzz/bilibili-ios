//
//  RegionModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionEntity.h"

@interface RegionModel : NSObject

@property (strong, nonatomic) NSArray<RegionEntity *> *regions;

- (void)getRegionListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
