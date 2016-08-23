//
//  DownloadVideoEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoEntity.h"

@interface DownloadVideoEntity ()
{
    NSMutableArray<DownloadVideoPageEntity *> *_pages;
}
@end

@implementation DownloadVideoEntity

@dynamic pages;

- (NSMutableArray<DownloadVideoPageEntity *> *)pages {
    if (!_pages) {
        _pages = [NSMutableArray array];
    }
    return _pages;
}

@end
