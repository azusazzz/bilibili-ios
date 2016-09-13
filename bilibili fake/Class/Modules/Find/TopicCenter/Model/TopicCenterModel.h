//
//  TopicCenterModel.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicEntity.h"

@interface TopicCenterModel : NSObject

@property(nonatomic,strong)NSMutableArray<TopicEntity *>* topicArr;

-(void)getTopicArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

-(void)getMoreTopicArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

@end
