//
//  RegionModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionModel.h"
#import "RegionRequest.h"

@implementation RegionModel

- (void)getRegionListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure {
    
    [[RegionRequest request] startWithCompletionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0 && [request.responseData isKindOfClass:[NSArray class]]) {
            
            _regions = [RegionEntity mj_objectArrayWithKeyValuesArray:request.responseData];
            
            success();
        }
        else {
            failure(request.errorMsg);
        }
    }];
    
}

@end
