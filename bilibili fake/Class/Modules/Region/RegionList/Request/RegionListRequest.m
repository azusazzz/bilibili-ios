//
//  RegionListRequest.m
//  bilibili fake
//
//  Created by cezr on 16/8/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionListRequest.h"

@implementation RegionListRequest

- (NSString *)URLString; {
    return @"http://app.bilibili.com/x/v2/region?access_key=f5bd4e793b82fba5aaf5b91fb549910a&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3470&device=phone&mobi_app=iphone&platform=ios&sign=c76b9aa1fbcefcbd9d08b862c050d16e";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 60 * 6;
}

@end
