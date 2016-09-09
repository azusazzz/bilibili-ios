//
//  AllVideoModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoModel.h"
#import "AllVideoRequest.h"
#import "TidNSDictionary.h"

@implementation AllVideoModel{
    AllVideoRequest* request;
}
-(instancetype)init{
    if (self = [super init]) {
        _videoArr = [[NSMutableArray alloc] init];
        request = [AllVideoRequest request];
        request.pn = 1;
        request.ps = 20;
        request.order = @"default";
        request.duration = 0;
        request.rid = 0;
    }
    return self;
}
-(void)setOrder:(NSInteger)order{
    _order = order;
    switch (order) {
        case 0:
            request.order = @"default";
            break;
         case 1:
            request.order = @"view";
            break;
        case 2:
            request.order = @"pubdate";
            break;
        case 3:
            request.order = @"danmaku";
            break;
        default:
            break;
    }
    [self clean];
}
-(void)setDuration:(NSInteger)duration{
    _duration = duration;
    request.duration = duration;
    [self clean];
}

-(void)setRidName:(NSString *)ridName{
    _ridName = ridName;
    request.rid = [[TidNSDictionary objectForKey:ridName] integerValue];
    [self clean];
}
-(void)clean{
    _videoArr = [[NSMutableArray alloc] init];
    request.pn = 1;
}

-(void)getSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{
    
}

-(void)getMoreSearchResultWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure{

}

@end
