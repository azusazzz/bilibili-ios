//
//  DanmakuConfiguration.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuConfiguration.h"

@implementation DanmakuConfiguration

+ (DanmakuConfiguration *)sharedConfiguration {
    static dispatch_once_t onceToken;
    static DanmakuConfiguration *object;
    dispatch_once(&onceToken, ^{
        object = [[DanmakuConfiguration alloc] init];
    });
    return object;
}

- (instancetype)init {
    if (self = [super init]) {
        _maxDisplayNumber = 60;
        _displayDuration = 5;
        _danmakuLabelAlpha = 0.8;
        _lineHeight = 24;
    }
    return self;
}


@end
