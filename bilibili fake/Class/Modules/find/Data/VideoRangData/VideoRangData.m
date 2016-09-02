//
//  VideoRangData.m
//  bilibili fake
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRangData.h"

@implementation VideoRangData{
    NSDictionary* title_URL;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        title_URL = @{
                      @"原创":@"http://www.bilibili.com/index/rank/origin-03.json",
                      @"全站":@"http://www.bilibili.com/index/rank/all-03.json",
                      @"新番":@"http://www.bilibili.com/index/rank/all-3-33.json",
                      @"番剧":@"http://www.bilibili.com/index/rank/all-03-13.json",
                      @"动画":@"http://www.bilibili.com/index/rank/all-03-1.json",
                      @"音乐":@"http://www.bilibili.com/index/rank/all-03-3.json",
                      @"舞蹈":@"http://www.bilibili.com/index/rank/all-03-129.json",
                      @"游戏":@"http://www.bilibili.com/index/rank/all-03-4.json",
                      @"科技":@"http://www.bilibili.com/index/rank/all-03-36.json",
                      @"生活":@"http://www.bilibili.com/index/rank/all-03-160.json",
                      @"鬼畜":@"http://www.bilibili.com/index/rank/all-03-155.json",
                      @"时尚":@"http://www.bilibili.com/index/rank/all-03-5.json",
                      @"娱乐":@"http://www.bilibili.com/index/rank/all-03-119.json",
                      @"电影":@"http://www.bilibili.com/index/rank/all-03-23.json",
                      @"电视剧":@"http://www.bilibili.com/index/rank/all-03-11.json"};

    }
    
//    http://www.bilibili.com/index/rank/all-03-
    return self;
}


-(void)getRangData:(NSString*)title block:(void(^)(NSMutableArray* data))block{
    NSString* urlstr = [title_URL objectForKey:title];
    if (urlstr.length == 0){
        urlstr = [title_URL objectForKey:@"全站"];
    }
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary* dataDic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@",dataDic);
            block([[dataDic objectForKey:@"rank"] objectForKey:@"list"]);
        }
        [session invalidateAndCancel];
    }] resume];


}

@end
