//
//  RegionListModel.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionListModel.h"
#import "RegionListRequest.h"

@implementation RegionListModel

- (void)getRegionListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure {
    
    [[RegionListRequest request] startWithCompletionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0 && [request.responseData isKindOfClass:[NSArray class]]) {
            
            _list = [RegionEntity mj_objectArrayWithKeyValuesArray:request.responseData];
            
            for (RegionEntity *region in _list) {
                if ([region.name isEqualToString:@"直播"]) {
                    region.param = @"bilibili://home/live";
                    break;
                }
            }
            
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
}

@end
