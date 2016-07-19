//
//  HomeChannelModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeChannelModel.h"
#import "HomeChannelRequest.h"

@interface HomeChannelModel ()

@end

@implementation HomeChannelModel


- (void)getChannelDataWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure; {
    [[HomeChannelRequest requestWithCompletionBlock:^(Request *request) {
        if (!request.responseObject) {
            failure ? failure(request.error.description) : NULL;
        }
        else {
            [self loadChannelDataWithJSONObject:request.responseObject];
            success ? success() : NULL;
        }
    }] resume];
}

- (void)loadChannelDataWithJSONObject:(id)JSONObject; {
    NSArray *array = [JSONObject valueForKeyPath:@"result.root"];
    _entitys = [HomeChannelEntity mj_objectArrayWithKeyValuesArray:array];
    [_entitys enumerateObjectsUsingBlock:^(HomeChannelEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.iconName = [NSString stringWithFormat:@"home_region_icon_%@", obj.tid];
    }];
    
    HomeChannelEntity *entity = [[HomeChannelEntity alloc] init];
    entity.name = @"直播";
    entity.iconName = @"home_region_icon_live";
    
    _entitys = [@[entity] arrayByAddingObjectsFromArray:_entitys];
}


@end
