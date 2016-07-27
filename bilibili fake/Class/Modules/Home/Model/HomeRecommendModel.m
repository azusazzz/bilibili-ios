//
//  HomeRecommendModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendModel.h"
#import "HomeRecommend.h"

@implementation HomeRecommendModel

- (void)getRecommendListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure {
    
    [[HomeRecommend request] startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            _recommendList = [HomeRecommendEntity mj_objectArrayWithKeyValuesArray:request.responseData];
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
    
}

@end
