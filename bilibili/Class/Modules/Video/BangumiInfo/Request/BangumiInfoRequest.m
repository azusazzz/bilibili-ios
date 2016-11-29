//
//  BangumiInfoRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoRequest.h"

@interface BangumiInfoRequest ()

@property (assign, nonatomic) NSInteger ID;

@end

@implementation BangumiInfoRequest


+ (instancetype)requestWithID:(NSInteger)ID {
    BangumiInfoRequest *request = [super request];
    request.ID = ID;
    return request;
}

- (NSString *)URLString {
    return @"http://bangumi.bilibili.com/jsonp/seasoninfo/##ID##.ver";
}

- (HTTPMethod)method {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval {
    return 60 * 30;
}

- (NSObject *)parameters {
    return @{@"ID": @(_ID)};
}


- (BOOL)willStoreCache {
    return [[self.responseObject objectForKey:@"code"] integerValue] == 0;
}


@end
