//
//  TopicCenterModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "TopicCenterModel.h"
#import "TopicCenterRequest.h"
@implementation TopicCenterModel{
    TopicCenterRequest *topicCenterRequest ;
    NSInteger pages;
}

-(void)getTopicArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    topicCenterRequest = [TopicCenterRequest request];
    topicCenterRequest.page = 0;
    pages = INTMAX_MAX;
    _topicArr = [[NSMutableArray alloc] init];
    [self getMoreTopicArrWithSuccess:success failure:failure];
}


-(void)getMoreTopicArrWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    if (++topicCenterRequest.page > pages) return;
    
    [topicCenterRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            pages = [[request.responseObject objectForKey:@"pages"] integerValue];
            NSArray<NSDictionary *>*arr = [request.responseObject objectForKey:@"list"];
            if (![arr isKindOfClass:[NSNull class]])[arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (((NSString*)([obj objectForKey:@"link"])).length&&((NSString*)([obj objectForKey:@"cover"])).length)
                    [_topicArr addObject:[TopicEntity mj_objectWithKeyValues:obj]];
            }];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];

}
@end
