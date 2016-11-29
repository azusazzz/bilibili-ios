//
//  BangumiRecommendRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiRecommendRequest.h"

@implementation BangumiRecommendRequest

- (NSString *)URLString; {
    return @"http://bangumi.bilibili.com/api/bangumi_recommend?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3480&cursor=0&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=64df3330f9e1a3797072be8e4f182b6c&ts=1470644187";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}

@end
