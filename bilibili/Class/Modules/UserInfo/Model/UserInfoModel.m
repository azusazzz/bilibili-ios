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
#import "UserInfoCoinVideosRequest.h"
#import "UserInfoFavoritesRequest.h"
#import "UserInfoBangumiRequest.h"
#import "UserInfoGameRequest.h"

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

}

-(void)getSubmitVideosEntityWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoSubmitVideosRequest* submitVideosRequest = [UserInfoSubmitVideosRequest request];
    submitVideosRequest.mid = _mid;
    [submitVideosRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _submitVideosEntity = [UserInfoSubmitVideosEntity mj_objectWithKeyValues:request.responseData];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}

-(void)getCoinVideosEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoCoinVideosRequest* coinVideosRequest = [UserInfoCoinVideosRequest request];
    coinVideosRequest.mid = _mid;
    [coinVideosRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _coinVideosEntity = [UserInfoCoinVideosEntity mj_objectWithKeyValues:request.responseData];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}

-(void)getFavoritesEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoFavoritesRequest* favoritesRequest = [UserInfoFavoritesRequest request];
    favoritesRequest.mid = _mid;
    [favoritesRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _favoritesEntityArr = [[NSMutableArray alloc] init];
            [((NSMutableArray*)request.responseData) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_favoritesEntityArr addObject:[UserInfoFavoritesEntity mj_objectWithKeyValues:obj]];
            }];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}

-(void)getBangumiEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoBangumiRequest* bangumiRequest = [UserInfoBangumiRequest request];
    bangumiRequest.mid = _mid;
    [bangumiRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _bangumiEntity = [UserInfoBangumiEntity mj_objectWithKeyValues:request.responseData];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}

-(void)getGameEntitySuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    UserInfoGameRequest* gameRequest = [UserInfoGameRequest request];
    gameRequest.mid = _mid;
    [gameRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _gameEntity = [UserInfoGameEntity mj_objectWithKeyValues:request.responseData];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}
@end
