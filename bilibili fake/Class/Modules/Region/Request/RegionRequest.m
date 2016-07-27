//
//  RegionRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionRequest.h"

@implementation RegionRequest


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
