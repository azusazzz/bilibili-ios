//
//  StartInfoRequest.m
//  bilibili fake
//
//  Created by C on 16/9/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "StartInfoRequest.h"


@implementation StartInfoRequest
- (NSString *)URLString; {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    return [NSString stringWithFormat:@"http://app.bilibili.com/x/splash?build=3390&channel=appstore&height=%0.0f&plat=1&width=%0.0f",height*scale_screen,width*scale_screen];
}

- (HTTPMethod)method; {
    return HTTPMethodGet;
}
@end
