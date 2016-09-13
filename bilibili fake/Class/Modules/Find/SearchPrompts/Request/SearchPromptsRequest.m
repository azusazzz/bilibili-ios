//
//  SearchPromptsRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchPromptsRequest.h"

@implementation SearchPromptsRequest
- (NSString *)URLString{
    return [[@"http://api.bilibili.com/suggest?actionKey=appkey&appkey=27eb53fc9058f8c3&term=" stringByAppendingString:self.keywork] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}

@end
