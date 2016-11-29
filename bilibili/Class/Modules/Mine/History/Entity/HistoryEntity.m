//
//  HistoryEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HistoryEntity.h"

@implementation HistoryEntity

- (instancetype)initWithVideoInfo:(VideoInfoEntity *)videoInfo {
    if (self = [super init]) {
        _aid = videoInfo.aid;
        _title = videoInfo.title;
        _pic = videoInfo.pic;
        _ownerName = videoInfo.owner.name;
        _viewCount = videoInfo.stat.view;
        _danmakuCount = videoInfo.stat.danmaku;
    }
    return self;
}


- (NSString *)title {
    if (!_title) {
        return @"";
    }
    return _title;
}

- (NSString *)pic {
    if (!_pic) {
        return @"";
    }
    return _pic;
}

- (NSString *)ownerName {
    if (!_ownerName) {
        return @"";
    }
    return _ownerName;
}

@end
