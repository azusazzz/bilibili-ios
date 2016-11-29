//
//  GameCenterModel.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCenterModel.h"
#import "GameCenterRequest.h"

@implementation GameCenterModel
-(void)getGameListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
//    GameCenterRequest* request =  [GameCenterRequest request];
//    [request startWithCompletionBlock:^(BaseRequest *request) {
//        if (request.responseCode == 0) {
//            _gameList = [GameListEntity mj_objectWithKeyValues:request.responseObject];
//            success();
//        }else{
//            failure(request.errorMsg);
//        }
//    }];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"游戏中心假数据" ofType:@"json"];
    NSMutableDictionary* dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
    _gameList = [GameListEntity mj_objectWithKeyValues:dic];
    success();
}

@end
