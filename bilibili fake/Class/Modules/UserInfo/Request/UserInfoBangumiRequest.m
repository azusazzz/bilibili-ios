//
//  UserInfoBangumiRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoBangumiRequest.h"

@implementation UserInfoBangumiRequest
- (NSString *)URLString; {
    NSString* url = [NSString stringWithFormat:@"http://space.bilibili.com/ajax/Bangumi/getList?mid=%lu",_mid];
    return url;
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
