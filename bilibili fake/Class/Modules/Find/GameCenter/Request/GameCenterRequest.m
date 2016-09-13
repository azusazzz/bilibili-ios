//
//  GameCenterRequest.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCenterRequest.h"

@implementation GameCenterRequest
- (NSString *)URLString{
    //调试用
    return @"http://api.biligame.com/app/iOS/homePage?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3620&cli_version=4.26&device=phone&mobi_app=iphone&platform=ios&sign=60cb9932a1e6022fb3b43fec18bd45a1&svr_version=1.1&timestamp=1473154270000&ts=1473154270&udid=1bb6ccf1c94f5e7da415a558fac8d4c9";
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}
@end
