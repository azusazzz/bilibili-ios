//
//  UserInfoGameRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoGameRequest.h"

@implementation UserInfoGameRequest
- (NSString *)URLString; {
    NSString* url = [NSString stringWithFormat:@"http://space.bilibili.com/ajax/game/GetLastPlay?mid=%lu",_mid];
    return url;
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
