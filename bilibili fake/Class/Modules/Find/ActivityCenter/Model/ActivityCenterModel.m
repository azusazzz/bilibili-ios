//
//  ActivityCenterModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ActivityCenterModel.h"
#import "ActivityCenterRequest.h"

@implementation ActivityCenterModel{
    ActivityCenterRequest *activityCenterRequest ;
    NSInteger pages;
}

-(void)getActivityArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    activityCenterRequest = [ActivityCenterRequest request];
    activityCenterRequest.page = 0;
    pages = INTMAX_MAX;
    _activityArr = [[NSMutableArray alloc] init];
    [self getMoreActivityArrWithSuccess:success failure:failure];
}


-(void)getMoreActivityArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    if (++activityCenterRequest.page > pages) return;
    
    [activityCenterRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            pages = [[request.responseObject objectForKey:@"pages"] integerValue];
            NSArray<NSDictionary *>*arr = [request.responseObject objectForKey:@"list"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (((NSString*)([obj objectForKey:@"link"])).length&&((NSString*)([obj objectForKey:@"cover"])).length)
                    [_activityArr addObject:[ActivityEntity mj_objectWithKeyValues:obj]];
            }];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
    
}



@end
