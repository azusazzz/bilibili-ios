//
//  DanmakuRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuRequest.h"

@interface DanmakuRequest ()

@property (assign, nonatomic) NSInteger cid;

@end

@implementation DanmakuRequest

+ (instancetype)requestWithCid:(NSInteger)cid {
    DanmakuRequest *request = [self request];
    request.cid = cid;
    return request;
}

- (NSString *)URLString {
    return @"http://comment.bilibili.com/##cid##.xml";
}

- (HTTPMethod)method {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval {
    return 60 * 60 * 3;
}

- (NSObject *)parameters {
    return @{@"cid": @(_cid)};
}

@end
