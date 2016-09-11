//
//  SearchResultModel.m
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultRequest.h"

@implementation SearchResultRequest
- (NSString *)URLString{
    NSString* path = [NSString stringWithFormat:@"http://app.bilibili.com/x/v2/search?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3710&device=phone&duration=0&keyword=%@&mobi_app=iphone&order=0&platform=ios&pn=1&ps=1&rid=0",_keywork];
    return  [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}
@end
