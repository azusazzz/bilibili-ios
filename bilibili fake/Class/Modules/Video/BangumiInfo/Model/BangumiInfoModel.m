//
//  BangumiInfoModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoModel.h"
#import "BangumiInfoRequest.h"

@interface BangumiInfoModel ()



@end

@implementation BangumiInfoModel


- (instancetype)initWithID:(NSInteger)ID {
    if (self = [super init]) {
        _ID = ID;
    }
    return self;
}


- (void)getBangumiInfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure {
    
    [[BangumiInfoRequest requestWithID:_ID] startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            self.bangumiInfo = [BangumiInfoEntity mj_objectWithKeyValues:request.responseObject[@"result"]];
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
}

@end
