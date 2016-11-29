//
//  UserInfoCoinVideosRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCoinVideosRequest.h"

@implementation UserInfoCoinVideosRequest

- (NSString *)URLString; {
    NSString* url = [NSString stringWithFormat:@"http://space.bilibili.com/ajax/member/getCoinVideos?mid=%lu&pagesize=2",_mid];
    return url;
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
