//
//  DownloadDataBase.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadDataBase.h"
#import <sqlite3.h>

@interface DownloadDataBase ()
{
    sqlite3 *sqlite;
}
@end

@implementation DownloadDataBase

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"Download.db"];
        if (sqlite3_open([path UTF8String], &sqlite) != SQLITE_OK) {
            printf("数据库打开失败\n");
        }
    }
    return self;
}

@end
