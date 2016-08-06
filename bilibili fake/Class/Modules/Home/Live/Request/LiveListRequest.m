//
//  LiveListRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListRequest.h"

@implementation LiveListRequest

- (NSString *)URLString; {
    return @"http://live.bilibili.com/AppIndex/home?access_key=f5bd4e793b82fba5aaf5b91fb549910a&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&device=phone&mobi_app=iphone&platform=ios&scale=3&sign=c7cec6cec8984c79a96275aad941271e&ts=1469613339";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}


@end
