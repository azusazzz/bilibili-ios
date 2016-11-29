//
//  LiveListModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListModel.h"
#import "LiveListRequest.h"

@implementation LiveListModel

- (void)getLiveListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    LiveListRequest *request = [LiveListRequest request];
    
    if (_liveList) {
        request.mustFromNetwork = YES;
    }
    
    [request startWithCompletionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0) {
            _liveList = [LiveListEntity mj_objectWithKeyValues:request.responseData];
            
            LiveListEntranceEntity *entrance1 = [[LiveListEntranceEntity alloc] init];
            entrance1.name = @"全部分类";
            LiveListEntranceEntity *entrance2 = [[LiveListEntranceEntity alloc] init];
            entrance2.name = @"全部直播";
            _liveList.entranceIcons = [_liveList.entranceIcons arrayByAddingObjectsFromArray:@[entrance1, entrance2]];
            
            success();
        }
        else {
            failure(request.errorMsg);
        }
        
    }];
    
}

@end
