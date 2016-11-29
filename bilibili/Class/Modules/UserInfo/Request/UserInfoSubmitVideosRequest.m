//
//  UserInfoSubmitVideosRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoSubmitVideosRequest.h"

@implementation UserInfoSubmitVideosRequest

- (NSString *)URLString; {
    return [NSString stringWithFormat:@"http://space.bilibili.com/ajax/member/getSubmitVideos?mid=%lu&tid=0&pagesize=6",_mid];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
