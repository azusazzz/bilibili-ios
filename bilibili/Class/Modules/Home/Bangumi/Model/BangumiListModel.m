//
//  BangumiListModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiListModel.h"
#import "BangumiListRequest.h"
#import "BangumiRecommendRequest.h"

@implementation BangumiListModel

- (void)getBangumiListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    BangumiListRequest *request = [BangumiListRequest request];
    
    if (self.bangumiList) {
        request.mustFromNetwork = YES;
    }
    
    [request startWithCompletionBlock:^(BaseRequest *request) {
        if ([request.responseObject objectForKey:@"result"]) {
            
            _bangumiList = [BangumiListEntity mj_objectWithKeyValues:[request.responseObject objectForKey:@"result"]];
            
            BangumiEntranceEntity *entrance1 = [[BangumiEntranceEntity alloc] init];
            entrance1.title = @"连载动画";
            entrance1.iconName = @"home_region_icon_33";
            BangumiEntranceEntity *entrance2 = [[BangumiEntranceEntity alloc] init];
            entrance2.title = @"完结动画";
            entrance2.iconName = @"home_region_icon_32";
            BangumiEntranceEntity *entrance3 = [[BangumiEntranceEntity alloc] init];
            entrance3.title = @"国产动画";
            entrance3.iconName = @"home_region_icon_153";
            BangumiEntranceEntity *entrance4 = [[BangumiEntranceEntity alloc] init];
            entrance4.title = @"官方延伸";
            entrance4.iconName = @"home_region_icon_152";
            
            _bangumiList.entrances = @[entrance1, entrance2, entrance3, entrance4];
            
            
            [[BangumiRecommendRequest request] startWithCompletionBlock:^(BaseRequest *request) {
                if ([request.responseObject objectForKey:@"result"]) {
                    _bangumiList.recommends = [BangumiRecommendEntity mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"result"]];
                    success();
                }
                else {
                    failure(request.errorMsg);
                }
            }];
            
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
}

@end
