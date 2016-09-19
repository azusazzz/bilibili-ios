//
//  UserInfoElecRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoElecRequest.h"

@implementation UserInfoElecRequest

- (NSString *)URLString; {
    NSString *str = [NSString stringWithFormat:@"http://elec.bilibili.com/api/query.rank.do?mid=%lu&type=json",_mid];
    return str;
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
//