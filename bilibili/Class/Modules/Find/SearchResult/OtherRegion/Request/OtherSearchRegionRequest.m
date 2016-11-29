//
//  OtherSearchRegion.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "OtherSearchRegionRequest.h"

@implementation OtherSearchRegionRequest
- (NSString *)URLString{
    NSString* path = [NSString stringWithFormat:@"http://app.bilibili.com/x/v2/search/type?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3710&device=phone&keyword=%@&mobi_app=iphone&platform=ios&pn=%lu&ps=%lu&type=%lu",_keyword,_pn,_ps,_type];
    return  [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}

@end
