//
//  DownloadModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel


+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



- (void)downloadVideo:(DownloadEntity *)download {
    
    for (DownloadItemEntity *item in download.items) {
        if ([self isDownloadRuningForAid:download.aid cid:item.cid]) {
            break;
        }
        
    }
    
    for (DownloadEntity *entity in self.list) {
        if (entity.aid == download.aid) {
            
        }
    }
}

- (BOOL)isDownloadRuningForAid:(NSInteger)aid cid:(NSInteger)cid {
    for (DownloadEntity *entity in self.list) {
        if (entity.aid == aid) {
            for (DownloadItemEntity *item in entity.items) {
                if (item.cid == cid) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

@end
