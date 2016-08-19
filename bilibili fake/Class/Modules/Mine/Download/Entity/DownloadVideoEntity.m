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

/*
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}*/

/*
- (void)insertPages:(NSArray<DownloadVideoPageEntity *> *)pages {
    NSArray<DownloadVideoPageEntity *> *selfPages = [self.pages copy];
    for (DownloadVideoPageEntity *page in pages) {
        BOOL hasPage = NO;
        for (DownloadVideoPageEntity *selfPage in selfPages) {
            if (page.cid == selfPage.cid) {
                hasPage = YES;
                break;
            }
        }
        if (!hasPage) {
            [_pages addObject:page];
        }
    }
}*/

- (NSMutableArray<DownloadVideoPageEntity *> *)pages {
    if (!_pages) {
        _pages = [NSMutableArray array];
    }
    return _pages;
}

@end
