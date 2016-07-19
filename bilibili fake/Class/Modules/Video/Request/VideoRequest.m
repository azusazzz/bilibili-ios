//
//  VideoRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRequest.h"

@implementation VideoRequest

- (NSString *)URLString {
    return @"http://app.bilibili.com/x/view?actionKey=appkey&aid=%@&appkey=27eb53fc9058f8c3";
}

- (HTTPMethod)method {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval {
    return 60 * 30;
}

- (NSObject *)parameters {
    return @{@"aid": @(1)};
}

@end
