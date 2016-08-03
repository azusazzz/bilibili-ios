//
//  VideoRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRequest.h"

@interface VideoRequest ()

@property (assign, nonatomic) NSInteger aid;

@end

@implementation VideoRequest

+ (instancetype)requestWithAid:(NSInteger)aid {
    VideoRequest *request = [super request];
    request.aid = aid;
    return request;
}

- (NSString *)URLString {
    return @"http://app.bilibili.com/x/view?actionKey=appkey&aid=##aid##&appkey=27eb53fc9058f8c3&build=3380";
}

- (HTTPMethod)method {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval {
    return 60 * 30;
}

- (NSObject *)parameters {
    return @{@"aid": @(_aid)};
}


- (BOOL)willStoreCache {
    return [[self.responseObject objectForKey:@"code"] integerValue] == 0;
}

@end
