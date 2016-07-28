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
            
            [_recommendList enumerateObjectsUsingBlock:^(HomeRecommendEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.type isEqualToString:@"recommend"]) {
                    obj.logoIconNmae = @"hd_home_recommend";
                }
                else if ([obj.type isEqualToString:@"live"]) {
                    obj.logoIconNmae = @"hd_home_subregion_live";
                }
                else if ([obj.type isEqualToString:@"bangumi"]) {
                    obj.logoIconNmae = @"hd_home_subregion_live";
                }
                else if ([obj.type isEqualToString:@"region"]) {
                    obj.logoIconNmae = [NSString stringWithFormat:@"home_region_icon_%@", obj.param];
                }
                else if ([obj.type isEqualToString:@"activity"]) {
                    obj.logoIconNmae = @"hd_home_subregion_live";
                }
                else {
                    obj.logoIconNmae = @"hd_home_recommend";
                }
            }];
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
    
}

@end
