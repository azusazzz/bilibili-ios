//
//  SearchAlertData.m
//  bilibili fake
//
//  Created by cxh on 16/7/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchPromptsData.h"

@implementation SearchPromptsData : NSObject

NSURLSessionDataTask* SearchPrompts_task;


+(NSString*)getSearchRecordsPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    NSString* path = [cachesPath stringByAppendingPathComponent:@"SearchRecords.plist"];
    NSFileManager* mgr = [NSFileManager defaultManager];
    if([mgr fileExistsAtPath:path] == NO)//查看文件是否存在
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"data":@[]}];
        [dic writeToFile:path atomically:YES];
    }
    return path;
}


+(NSMutableArray*)getSearchRecords{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[SearchPromptsData getSearchRecordsPath]];
    NSMutableArray* outArr = [dic objectForKey:@"data"];
    if (outArr == nil) {
        outArr = [[NSMutableArray alloc] init];
    }
    return outArr;
}

+(void)setSearchRecords:(NSMutableArray*)arr{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[SearchPromptsData getSearchRecordsPath]];
    [dic setObject:arr forKey:@"data"];
    [dic writeToFile:[SearchPromptsData getSearchRecordsPath] atomically:YES];
}

+(void)clearSearchRecords{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"data":@[]}];
    [dic writeToFile:[SearchPromptsData getSearchRecordsPath] atomically:YES];
}




+(void)getSearchPrompts:(NSString*)keywork Block:(void(^)(NSMutableArray* Prompts))block{
    if(SearchPrompts_task)[SearchPrompts_task cancel];//先取消上一个任务
    
    NSString* urlstr = [@"http://api.bilibili.com/suggest?actionKey=appkey&appkey=27eb53fc9058f8c3&term=" stringByAppendingString:keywork];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;//忽略本地缓存数据
    NSURLSession *session = [NSURLSession sharedSession];
    SearchPrompts_task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
          NSMutableArray* Prompts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            block(Prompts);
        }
        [session invalidateAndCancel];
    }];

    [SearchPrompts_task resume];

}

+(void)clear{
    SearchPrompts_task = nil;
}
@end
