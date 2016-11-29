//
//  RegionListModel.h
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionEntity.h"

@interface RegionListModel : NSObject

@property (strong, nonatomic) NSArray<RegionEntity *> *list;

- (void)getRegionListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


@end
