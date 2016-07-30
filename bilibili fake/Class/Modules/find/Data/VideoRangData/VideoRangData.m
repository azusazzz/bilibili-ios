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
                      @"新番":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=10000&access_key=00f9ffc794b0912baa40e1467661692f&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=33&type=json&sign=3327744eeeb1564e522e964686090a90",
                      @"动画":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=1&type=json&sign=d516656846cd5675248e927b040e7aed",
                      @"音乐":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=129&type=json&sign=b9a44cee19a5b887e0b5c326f009a6b6",
                      @"舞蹈":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=129&type=json&sign=b9a44cee19a5b887e0b5c326f009a6b6",
                      @"游戏":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=4&type=json&sign=a4c69225ecb5d47211254ad813882c72",
                      @"科技":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=36&type=json&sign=c9ac2d1ad78ceed76a56c6ab8e91b556",
                      @"生活":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=160&type=json&sign=186a95624dbae12490e6eae2505d3f6a",
                      @"鬼畜":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=119&type=json&sign=4f0197ecf717c29968be2d6ac5fc1f02",
                      @"时尚":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=155&type=json&sign=03cca4dc81e385ef3dfe3133edef2c90",
                      @"娱乐":@"http://api.bilibili.com/list?_device=iphone&_hwid=1bb6ccf1c94f5e7d&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3390&build=3390&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=5&type=json&sign=52e54aacdee9c594f2052492d87ae4c2"};

    }
    return self;
}

- (void)dealloc {
    LogDEBUG(@"%s", __FUNCTION__);
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
