//
//  DanmakuRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuRequest.h"

@implementation DanmakuRequest

- (NSString *)URLString {
    return @"http://comment.bilibili.com/9279683.xml";
}

- (HTTPMethod)method {
    return HTTPMethodGet;
}

@end
