//
//  VideoRankRequest.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRankRequest.h"

@implementation VideoRankRequest
- (NSString *)URLString{
    NSDictionary* titleURLDic =  @{@"原创":@"http://www.bilibili.com/index/rank/origin-03.json",
                                   @"全站":@"http://www.bilibili.com/index/rank/all-03.json",
                                   @"新番":@"http://www.bilibili.com/index/rank/all-3-33.json",
                                   @"番剧":@"http://www.bilibili.com/index/rank/all-03-13.json",
                                   @"动画":@"http://www.bilibili.com/index/rank/all-03-1.json",
                                   @"音乐":@"http://www.bilibili.com/index/rank/all-03-3.json",
                                   @"舞蹈":@"http://www.bilibili.com/index/rank/all-03-129.json",
                                   @"游戏":@"http://www.bilibili.com/index/rank/all-03-4.json",
                                   @"科技":@"http://www.bilibili.com/index/rank/all-03-36.json",
                                   @"生活":@"http://www.bilibili.com/index/rank/all-03-160.json",
                                   @"鬼畜":@"http://www.bilibili.com/index/rank/all-03-155.json",
                                   @"时尚":@"http://www.bilibili.com/index/rank/all-03-5.json",
                                   @"娱乐":@"http://www.bilibili.com/index/rank/all-03-119.json",
                                   @"电影":@"http://www.bilibili.com/index/rank/all-03-23.json",
                                   @"电视剧":@"http://www.bilibili.com/index/rank/all-03-11.json"};
    return [titleURLDic objectForKey:_title];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}

- (NSTimeInterval)cacheTimeoutInterval; {
    return 60 * 30;
}
@end
