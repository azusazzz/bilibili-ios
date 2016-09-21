//
//  DownloadVideoModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoModel.h"
#import <sqlite3.h>

@interface DownloadVideoModel ()
{
    NSMutableArray *_list;
    sqlite3 *sqlite;
}


@property (strong, nonatomic) NSArray<DownloadVideoEntity *> *list;

@end

@implementation DownloadVideoModel

@dynamic list;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            [DownloadVideoModel sharedInstance];
        });
    });
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return NULL;
    }
    _list = [NSMutableArray array];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"DownloadVideo.db"];
    if (sqlite3_open([path UTF8String], &sqlite) != SQLITE_OK) {
        printf("数据库打开失败\n");
    }
    
    char *error = NULL;
    
    NSString *createTableSQL = @"CREATE TABLE DownloadVideo (cid INTEGER PRIMARY KEY, part STRING, page INTEGER, fileName STRING, aid INTEGER NOT NULL, title STRING, pic STRING, date INTEGER);";
    sqlite3_exec(sqlite, [createTableSQL UTF8String], NULL, NULL, &error);
    
    
    char **pResult;
    int row, col;
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT aid,title,pic, cid,part,page,fileName FROM DownloadVideo ORDER BY date ASC;"];
    if (sqlite3_get_table(sqlite, [selectSQL UTF8String], &pResult, &row, &col, &error) != SQLITE_OK) {
        printf("%s\n", error);
        return self;
    }
    
    if (row <= 0) {
        return self;
    }
    
    for (int r=1; r<=row; r++) {
        NSInteger aid = [[NSString stringWithUTF8String:pResult[0+r*col]] integerValue];
        DownloadVideoEntity *download;
        for (DownloadVideoEntity *_download in _list) {
            if (_download.aid == aid) {
                download = _download;
                break;
            }
        }
        
        if (!download) {
            download = [[DownloadVideoEntity alloc] init];
            download.aid = aid;
            download.title = [NSString stringWithUTF8String:pResult[1+r*col]];
            download.pic = [NSString stringWithUTF8String:pResult[2+r*col]];
            [_list addObject:download];
        }
        
        DownloadVideoPageEntity *page = [[DownloadVideoPageEntity alloc] init];
        for (int c=3; c<col; c++) {
            NSString *key = [NSString stringWithUTF8String:pResult[c]];
            id value = [NSString stringWithUTF8String:pResult[c+r*col]];
            [page setValue:value forKey:key];
        }
        page.aid = aid;
        [download.pages addObject:page];
    }
    
    
    return self;
}

- (void)downloadVideo:(DownloadVideoEntity *)download {
    
    for (DownloadVideoEntity *entity in _list) {
        NSInteger pagesCount = [entity.pages count];
        if (entity.aid == download.aid) {
            for (DownloadVideoPageEntity *page in download.pages) {
                BOOL hasPage = NO;
                for (NSInteger i=0; i<pagesCount; i++) {
                    if (page.cid == entity.pages[i].cid) {
                        hasPage = YES;
                        break;
                    }
                }
                if (!hasPage) {
                    // add
                    [entity.pages addObject:page];
                    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO DownloadVideo (cid, part, page, fileName, aid, title, pic, date) VALUES (%ld, \'%@\', %ld, \'%@\', %ld, \'%@\', \'%@\', %ld);", page.cid, page.part, page.page, @"", download.aid, download.title, download.pic, (NSInteger)[NSDate date].timeIntervalSince1970];
                    char *error = NULL;
                    if (sqlite3_exec(sqlite, [insertSQL UTF8String], NULL, NULL, &error) != SQLITE_OK) {
                        printf("%s\n", error);
                    }
                }
            }
            return;
        }
    }
    
    [_list addObject:download];
    
    for (DownloadVideoPageEntity *page in download.pages) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO DownloadVideo (cid, part, page, fileName, aid, title, pic, date) VALUES (%ld, \'%@\', %ld, \'%@\', %ld, \'%@\', \'%@\', %ld);", page.cid, page.part, page.page, @"", download.aid, download.title, download.pic, (NSInteger)[NSDate date].timeIntervalSince1970];
        char *error = NULL;
        if (sqlite3_exec(sqlite, [insertSQL UTF8String], NULL, NULL, &error) != SQLITE_OK) {
            printf("%s\n", error);
        }
    }
    
}


- (DownloadVideoPageEntity *)hasVideoPageWithAid:(NSInteger)aid cid:(NSInteger)cid {
    for (DownloadVideoEntity *entity in self.list) {
        if (entity.aid == aid) {
            for (DownloadVideoPageEntity *page in entity.pages) {
                if (page.cid == cid) {
                    return page;
                }
            }
        }
    }
    return NULL;
}


- (void)getDownlaodVideosWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    success();
    
}


- (void)deleteVideoWithAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *))failure {
    __block DownloadVideoEntity *video = NULL;
    for (DownloadVideoEntity *obj in self.list) {
        if (obj.aid == aid) {
            video = obj;
            break;
        }
    }
    
    [_list enumerateObjectsUsingBlock:^(DownloadVideoEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.aid == aid) {
            video = obj;
            [_list removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
    
    
    if (!video) {
        failure(@"");
        return;
    }
    
    for (DownloadVideoPageEntity *page in video.pages) {
        [page.operation stop];
        if (page.filePath) {
            [[NSFileManager defaultManager] removeItemAtPath:page.filePath error:NULL];
        }
    }
    
    char *error = NULL;
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM DownloadVideo WHERE aid=%ld", aid];
    sqlite3_exec(sqlite, [deleteSQL UTF8String], NULL, NULL, &error);
    
    success();
}

- (NSArray<DownloadVideoEntity *> *)list {
    return _list;
}





@end
