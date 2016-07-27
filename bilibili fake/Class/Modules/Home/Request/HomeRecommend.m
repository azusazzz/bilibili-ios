//
//  HomeRecommend.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommend.h"

@implementation HomeRecommend

- (NSString *)URLString; {
    return @"http://app.bilibili.com/x/v2/show?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=1c8f22ff72d7cab05a94eb8b12a4c4cc&ts=1469603875&warm=1";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}


@end
