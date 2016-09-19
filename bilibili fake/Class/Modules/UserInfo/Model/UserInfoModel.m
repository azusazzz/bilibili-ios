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
#import "UserInfoElecRequest.h"
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


-(void)getElecEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoElecRequest* elecRequest = [UserInfoElecRequest request];
    elecRequest.mid = _mid;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[elecRequest URLString]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary* dataDic =  [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            _elecEntity = [UserInfoElecEntity mj_objectWithKeyValues:[dataDic objectForKey:@"data"]];
            success();
        }
        [session invalidateAndCancel];
    }] resume];
    
    
//    [elecRequest startWithCompletionBlock:^(BaseRequest *request) {
//        NSLog(@"%@",request.responseObject);
//        if (request.responseCode == 0) {
//            _elecEntity = [UserInfoElecEntity mj_objectWithKeyValues:request.responseData];
//            success();
//        }else{
//            failure(request.errorMsg);
//        }
//    }];
}


@end
