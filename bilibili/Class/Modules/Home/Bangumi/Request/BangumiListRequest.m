//
//  BangumiListRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiListRequest.h"

@implementation BangumiListRequest

- (NSString *)URLString; {
    return @"http://bangumi.bilibili.com/api/app_index_page_v3?access_key=f5bd4e793b82fba5aaf5b91fb549910a&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&device=phone&mobi_app=iphone&platform=ios&sign=716eb95b22774147de092249c4605e30&ts=1469613339";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}



@end
