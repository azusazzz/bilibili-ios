//
//  UserInfoFavoritesRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoFavoritesRequest.h"

@implementation UserInfoFavoritesRequest

- (NSString *)URLString; {
    NSString* url = [NSString stringWithFormat:@"http://api.bilibili.com/x/app/favourite/folder?&vmid=%lu",_mid];
    return url;
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

@end
