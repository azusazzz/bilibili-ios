//
//  StartInfo.m
//  bilibili fake
//
//  Created by C on 16/9/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "StartInfoModel.h"
#import "StartInfoRequest.h"
#import "StartInfoEntity.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation StartInfoModel{
    NSString* savePath;
    StartInfoEntity* startInfoEntity;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        //检查是否有启动图数据
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        savePath = [cachesPath stringByAppendingPathComponent:@"CXHstarView_data.json"];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:savePath] == YES){//查看文件是否存在
            startInfoEntity = [StartInfoEntity mj_objectWithFile:savePath];
            //获取当前的时间戳
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now_time=[dat timeIntervalSince1970];
            
            for (StartPageEntity* startPage in startInfoEntity.startPages) {
                //启动图是否已加载
                if(startPage.end_time > now_time && startPage.start_time < now_time){
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    if ([manager diskImageExistsForURL:[NSURL URLWithString:startPage.image]]) {
                        _currentStartPage = startPage;
                    }
                }
            }
            //调试用
            //_currentStartPage = [startInfoEntity.startPages lastObject];
            //_currentStartPage.param = @"http://www.bilibili.com/video/av2344701/";
        }
    }
    
    [self update];
    return self;
}


//刷新本地数据
-(void)update{
    StartInfoRequest* request =  [StartInfoRequest request];
    [request startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseCode == 0) {
            //保存数据
            [request.responseObject writeToFile:savePath atomically:YES];
            startInfoEntity = [StartInfoEntity mj_objectWithKeyValues:request.responseObject];
            //获取当前的时间戳
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now_time=[dat timeIntervalSince1970];
            
            for (StartPageEntity* startPage in startInfoEntity.startPages) {
                if (startPage.end_time>now_time) {
                    [[UIImageView new] sd_setImageWithURL:[NSURL URLWithString:startPage.image]];
                    //[[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:startPage.image] options:SDWebImageDownloaderIgnoreCachedResponse progress:NULL completed:NULL];
                }
            }
        }
    }];
}
@end
