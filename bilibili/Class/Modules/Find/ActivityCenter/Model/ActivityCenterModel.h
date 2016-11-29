//
//  ActivityCenterModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityEntity.h"

@interface ActivityCenterModel : NSObject

@property(nonatomic,strong)NSMutableArray<ActivityEntity *>* activityArr;

-(void)getActivityArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getMoreActivityArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
