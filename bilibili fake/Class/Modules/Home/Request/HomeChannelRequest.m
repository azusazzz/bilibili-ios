//
//  HomeChannelRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeChannelRequest.h"

@implementation HomeChannelRequest

- (NSString *)URLString; {
    return @"http://app.bilibili.com/x/region/list/old";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}

@end
