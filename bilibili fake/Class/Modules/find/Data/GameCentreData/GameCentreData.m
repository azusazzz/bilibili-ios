//
//  GameCentreData.m
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCentreData.h"

@implementation GameCentreData

+(instancetype)share{
    return [[GameCentreData alloc] init];
}



-(void)getGamesInfo:(void (^)(NSArray *GamesInfo))block{
//    NSString* urlstr = @"http://api.biligame.com/app/iOS/homePage?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3390&cli_version=4.22.1&device=phone&mobi_app=iphone&platform=ios&sign=0d404d56af376b8c19d95e8700161402&svr_version=1.1&timestamp=1469068122000&ts=1469068122&udid=1bb6ccf1c94f5e7da415a558fac8d4c9";
//    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
////    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;//忽略本地缓存数据
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error) {
//            NSDictionary* dataDic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@",dataDic);
//            block([dataDic objectForKey:@"items"]);
//        }
//        [session invalidateAndCancel];
//    }] resume];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"游戏中心假数据" ofType:@"json"];
    NSMutableDictionary* dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
    block([dic objectForKey:@"items"]);
    
}
@end
