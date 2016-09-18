//
//  UserInfoModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoModel.h"
#import "UserInfoCardRequest.h"
#import "UserInfoLiveRequest.h"
#import "UserInfoSubmitVideosRequest.h"



@implementation UserInfoModel

-(instancetype)initWithMid:(NSInteger)mid{
    if (self = [super init]) {
        _mid = mid;
    }
    return self;
}


-(void)getCardEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoCardRequest* cardRequest = [UserInfoCardRequest request];
    cardRequest.mid = _mid;
    [cardRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _cardEntity = [UserInfoCardEntity mj_objectWithKeyValues:[request.responseObject objectForKey:@"card"]];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}

-(void)getLiveEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoLiveRequest* liveRequest = [UserInfoLiveRequest request];
    liveRequest.mid = _mid;
    [liveRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _liveEntity = [UserInfoLiveEntity mj_objectWithKeyValues:request.responseData];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}


@end
