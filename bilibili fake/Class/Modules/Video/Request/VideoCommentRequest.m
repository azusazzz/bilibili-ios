//
//  VideoCommentRequest.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentRequest.h"

@interface VideoCommentRequest ()

@property (assign, nonatomic) NSInteger aid;

@property (assign, nonatomic) NSInteger page;

@property (assign, nonatomic) NSInteger pagesize;

@end

@implementation VideoCommentRequest

+ (instancetype)requestWithAid:(NSInteger)aid {
    VideoCommentRequest *request = [super request];
    request.aid = aid;
    request.page = 1;
    request.pagesize = 10;
    return request;
}

- (NSString *)URLString {
    return @"http://api.bilibili.com/feedback?page=##page##&aid=##aid##&pagesize=##pagesize##&ver=3";
}

- (HTTPMethod)method {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval {
    return 60 * 30;
}

- (NSObject *)parameters {
    return @{@"aid": @(_aid), @"page": @(_page), @"pagesize": @(_pagesize)};
}


@end
