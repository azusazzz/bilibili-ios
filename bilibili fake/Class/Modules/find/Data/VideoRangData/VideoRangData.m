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
                      @"原创":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=10000&access_key=00f9ffc794b0912baa40e1467661692f&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&original=1&page=0&pagesize=20&platform=ios&type=json&sign=5099f7aac89d3810951c65616dc42767",
                      @"全站":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=10000&access_key=00f9ffc794b0912baa40e1467661692f&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&type=json&sign=267363468867de0b61f46727b88cd219",
                      @"新番":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=10000&access_key=00f9ffc794b0912baa40e1467661692f&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=33&type=json&sign=3327744eeeb1564e522e964686090a90"};

    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

-(void)getRangData:(NSString*)title block:(void(^)(NSMutableDictionary* data))block{
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
            block([dataDic objectForKey:@"list"]);
        }
        [session invalidateAndCancel];
    }] resume];


}

@end
