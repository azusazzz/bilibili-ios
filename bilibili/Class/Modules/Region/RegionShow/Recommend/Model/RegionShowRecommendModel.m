//
//  RegionShowRecommendModel.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowRecommendModel.h"
#import "RegionShowRecommendRequest.h"


@interface RegionShowRecommendModel ()

@property (assign, nonatomic) NSInteger rid;

@property (strong, nonatomic) RegionShowRecommendEntity *regionShow;

@end

@implementation RegionShowRecommendModel

- (instancetype)initWithRid:(NSInteger)rid
{
    self = [super init];
    if (self) {
        _rid = rid;
    }
    return self;
}

- (void)getRegionShowWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure
{
    RegionShowRecommendRequest *request = [RegionShowRecommendRequest requestWithRid:_rid];
    
    [request startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseData) {
            self.regionShow = [RegionShowRecommendEntity mj_objectWithKeyValues:request.responseData];
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
}

@end
