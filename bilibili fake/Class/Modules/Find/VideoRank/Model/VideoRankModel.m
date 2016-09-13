//
//  VideoRankModel.m
//  bilibili fake
//
//  Created by C on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRankModel.h"
#import "VideoRankRequest.h"

@implementation VideoRankModel{
    VideoRankRequest* videoRankRequest;
}
-(instancetype)init{
    if ([super init]) {
        videoRankRequest = [VideoRankRequest request];
    }
    return self;
}
-(void)getvideoRankingWithTitle:(NSString*)title success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    videoRankRequest.title = title;
    _videoRanking = [[NSMutableArray alloc] init];
    [videoRankRequest startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            NSArray<NSDictionary*>* list = [[request.responseObject objectForKey:@"rank"] objectForKey:@"list"];
            [list enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                RankingVideoEntity* entity = [RankingVideoEntity mj_objectWithKeyValues:obj];
                entity.ranking = idx+1;
                [_videoRanking addObject:entity];
            }];
            success();
        }else{
            failure(request.errorMsg);
        }
    }];
}
@end
