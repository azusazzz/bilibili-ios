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

- (DownloadOperationStatus)status {
    if (self.countRuning > 0) {
        return DownloadOperationStatusRuning;
    }
    else if (self.countWaiting > 0) {
        return DownloadOperationStatusWaiting;
    }
    else if (self.countWaiting > 0) {
        return DownloadOperationStatusPause;
    }
    else {
        return DownloadOperationStatusSuccess;
    }
    /*
    DownloadOperationStatus status = DownloadOperationStatusSuccess;
    for (DownloadVideoPageEntity *page in _pages) {
        if (page.operation.status == DownloadOperationStatusRuning) {
            return DownloadOperationStatusRuning;
        }
        else if (page.operation.status == DownloadOperationStatusWaiting) {
            status = status != DownloadOperationStatusRuning ? DownloadOperationStatusWaiting : status;
        }
        else if (page.operation.status == DownloadOperationStatusPause) {
            status = status != DownloadOperationStatusRuning && status != DownloadOperationStatusWaiting ? DownloadOperationStatusPause : status;
        }
    }
    return status;*/
}

- (NSUInteger)countSuccess {
    NSUInteger count = 0;
    for (DownloadVideoPageEntity *page in _pages) {
        if ([page.fileName length] > 0) {
            ++count;
        }
    }
    return count;
}
- (NSUInteger)countRuning {
    NSUInteger count = 0;
    for (DownloadVideoPageEntity *page in _pages) {
        if (page.operation.status == DownloadOperationStatusRuning) {
            ++count;
        }
    }
    return count;
}
- (NSUInteger)countWaiting {
    NSUInteger count = 0;
    for (DownloadVideoPageEntity *page in _pages) {
        if (page.operation.status == DownloadOperationStatusWaiting) {
            ++count;
        }
    }
    return count;
}

@end
