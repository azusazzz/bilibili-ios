//
//  HomeAnimationRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationRequest.h"

@implementation HomeAnimationRequest

- (NSString *)URLString; {
    return @"http://bangumi.bilibili.com/api/app_index_page";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}

@end
