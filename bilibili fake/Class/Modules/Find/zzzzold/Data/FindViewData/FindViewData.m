//
//  FindViewData.m
//  bilibili fake
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindViewData.h"

@implementation FindViewData

+(void)getKeyword:(void(^)(NSMutableArray* keyword_arr))block{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://s.search.bilibili.com/main/hotword?access_key=ec0f54fc369d8c104ee1068672975d6a&actionKey=appkey&appkey=27eb53fc9058f8c3"]];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;//忽略本地缓存数据
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error){
         NSDictionary* dataDic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@",dataDic);
            NSArray* arr = [dataDic objectForKey:@"list"];
            NSMutableArray* outarr = [[NSMutableArray alloc] init];
            for (NSDictionary* dic in arr) {
                NSString* keyword = [dic objectForKey:@"keyword"];
                if (keyword&&keyword.length) {
                    [outarr addObject:keyword];
                }
            }
            block(outarr);
        }
     }] resume];

}

@end
