//
//  UserInfoLiveRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoLiveRequest.h"

@implementation UserInfoLiveRequest

- (NSString *)URLString; {
    return [NSString stringWithFormat:@"http://live.bilibili.com/AppRoom/getRoomInfo?mid=%lu",_mid];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
