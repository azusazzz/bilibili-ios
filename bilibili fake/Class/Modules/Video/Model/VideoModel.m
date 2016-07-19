//
//  VideoModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoModel.h"
#import "VideoRequest.h"

@implementation VideoModel

- (void)getVideoInfoWithAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    [[VideoRequest requestWithAid:aid] startWithCompletionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0) {
            success();
        }
        else {
            failure(request.errorMsg);
        }
        
    }];
    
}

@end
