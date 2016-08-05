//
//  HistoryModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HistoryModel.h"
#import <sqlite3.h>

#ifdef TARGET_IPHONE_SIMULATOR

#define DB_PATH @"/Users/cezr/Desktop/History.db"

#else

#define DB_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"History.db"]

#endif

@implementation HistoryModel


+ (void)addHistory:(HistoryEntity *)history {
    if ([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addHistory:history];
        });
        return;
    }
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"History.db"];
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
    
    NSString *createTableSQL = @"CREATE TABLE History (aid INTEGER PRIMARY KEY, title STRING, pic STRING, ownerName STRING, viewCount INTEGER, danmakuCount INTEGER, date INTEGER);";
    sqlite3_exec(sqlite, [createTableSQL UTF8String], NULL, NULL, &error);
    
    NSInteger date = [NSDate date].timeIntervalSince1970;
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO History (aid, title, pic, ownerName, viewCount, danmakuCount, date) VALUES (%ld, \'%@\', \'%@\', \'%@\', %ld, %ld, %ld);", history.aid, history.title, history.pic, history.ownerName, history.viewCount, history.danmakuCount, date];
    if (sqlite3_exec(sqlite, [insertSQL UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        NSString *updateSQL = [NSString stringWithFormat:@"UPDATE History SET date = %ld WHERE aid = %ld;", date, history.aid];
        sqlite3_exec(sqlite, [updateSQL UTF8String], NULL, NULL, &error);
    }
}


- (void)deleteAllHistoryWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"History.db"];
    sqlite3 *sqlite;
    if (sqlite3_open([path UTF8String], &sqlite) != SQLITE_OK) {
        printf("数据库打开失败\n");
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(@"数据库打开失败");
        });
        return;
    }
    
    char *error = NULL;
    
    Defer {
        sqlite3_close(sqlite);
        if (error) {
            printf("SQLITE ERROR: %s\n", error);
        }
    };
    
    NSString *deleteSQL = @"DELETE FROM History";
    if (sqlite3_exec(sqlite, [deleteSQL UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        failure([NSString stringWithUTF8String:error]);
        return;
    }
    
    self.list = @[];
    success();
    
}


- (void)getHistoryListWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    if ([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getHistoryListWithSuccess:success failure:failure];
        });
        return;
    }
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"History.db"];
    sqlite3 *sqlite;
    if (sqlite3_open([path UTF8String], &sqlite) != SQLITE_OK) {
        printf("数据库打开失败\n");
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(@"数据库打开失败");
        });
        return;
    }
    
    char *error = NULL;
    
    Defer {
        sqlite3_close(sqlite);
        if (error) {
            printf("SQLITE ERROR: %s\n", error);
        }
    };
    
    char **pResult;
    int row, col;
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM History COMPANY ORDER BY date DESC LIMIT 100"];
    if (sqlite3_get_table(sqlite, [selectSQL UTF8String], &pResult, &row, &col, &error) != SQLITE_OK) {
        dispatch_async(dispatch_get_main_queue(), ^{
            success();
        });
        return;
    }
    
    if (row <= 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            success();
        });
        return;
    }
    
    
    
    
    
    
    NSMutableArray<HistoryEntity *> *list = [NSMutableArray arrayWithCapacity:row];
    for (int r=1; r<=row; r++) {
        HistoryEntity *history = [[HistoryEntity alloc] init];
        for (int c=0; c<col-1; c++) {
            NSString *key = [NSString stringWithUTF8String:pResult[c]];
            id value = [NSString stringWithUTF8String:pResult[c+r*col]];
            [history setValue:value forKey:key];
        }
        [list addObject:history];
    }
    
    _list = [NSArray arrayWithArray:list];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        success();
    });
    
    if (row == 100) {
        // 删除可能存在的更多数据
        NSInteger minDate = [[NSString stringWithUTF8String:pResult[col-1 + row * col]] integerValue];
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM History WHERE date<%ld", minDate];
        sqlite3_exec(sqlite, [deleteSQL UTF8String], NULL, NULL, &error);
    }
    
}

@end
