//
//  UserInfoCardRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCardRequest.h"

@implementation UserInfoCardRequest

- (NSString *)URLString; {
    return [NSString stringWithFormat:@"https://account.bilibili.com/api/member/getCardByMid?mid=%lu",_mid];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end