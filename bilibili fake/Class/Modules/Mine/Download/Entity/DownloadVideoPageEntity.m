//
//  DownloadVideoPageEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoPageEntity.h"
#import <sqlite3.h>
#import <ReactiveCocoa.h>

@interface DownloadVideoPageEntity ()
{
    DownloadOperation *_operation;
    
    
}

@property (strong, nonatomic) RACDisposable *statusDisposable;

@end

@implementation DownloadVideoPageEntity

@dynamic operation;

- (void)dealloc {
    [_statusDisposable dispose];
}

- (DownloadOperation *)operation {
    if (!_operation && _aid > 0 && _cid > 0) {
        _operation = [[DownloadManager manager] operationWithAid:_aid cid:_cid page:_page];
        __weak typeof(self) weakself = self;
        _statusDisposable = [RACObserve(_operation, status) subscribeNext:^(id x) {
            if ([x integerValue] == DownloadOperationStatusSuccess) {
                weakself.fileName = [weakself.operation.filePath lastPathComponent];
                [weakself.statusDisposable dispose];
                weakself.statusDisposable = NULL;
            }
            else if ([x integerValue] == DownloadOperationStatusFailure) {
                [weakself.statusDisposable dispose];
                weakself.statusDisposable = NULL;
            }
        }];
    }
    return _operation;
}

- (void)setFileName:(NSString *)fileName {
    
    if (_fileName && ![_fileName isEqualToString:fileName]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"DownloadVideo.db"];
        sqlite3 *sqlite;
        if (sqlite3_open([path UTF8String], &sqlite) != SQLITE_OK) {
            printf("数据库打开失败\n");
            return;
        }
        
        char *error = NULL;
        
        Defer {
            sqlite3_close(sqlite);
            if (error) {
                printf("SQLITE ERROR: %s\n", error);
            }
        };
        
        NSString *updateSQL = [NSString stringWithFormat:@"UPDATE DownloadVideo SET fileName = \'%@\' WHERE cid = %ld;", fileName, _cid];
        sqlite3_exec(sqlite, [updateSQL UTF8String], NULL, NULL, &error);
    }
    
    _fileName = fileName;
}

- (NSString *)filePath {
    if (!_fileName) {
        return NULL;
    }
    return [DownloadDirectory stringByAppendingPathComponent:_fileName];
}

- (void)insertDatabase {
    
}

@end
