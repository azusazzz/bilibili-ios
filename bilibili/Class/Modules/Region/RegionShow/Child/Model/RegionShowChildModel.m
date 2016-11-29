//
//  RegionShowChildModel.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowChildModel.h"
#import "RegionShowChildRequest.h"

@interface RegionShowChildModel ()

@property (assign, nonatomic) NSInteger rid;

@property (strong, nonatomic) RegionShowChildEntity *regionShowChild;

@end

@implementation RegionShowChildModel

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
    RegionShowChildRequest *request = [RegionShowChildRequest requestWithRid:_rid];
    
    [request startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseData) {
            self.regionShowChild = [RegionShowChildEntity mj_objectWithKeyValues:request.responseData];
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
}

@end
