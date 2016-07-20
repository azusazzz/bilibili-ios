//
//  StartVCData.m
//  bilibili fake
//
//  Created by cxh on 16/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "StartVCData.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation StartVCData{
    NSString* startView_data_path;//启动图数据储存路径
}

+(NSMutableDictionary*)getStartViewData{
    return [[[StartVCData alloc] init] getStartViewData];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

-(NSMutableDictionary*)getStartViewData{
    //检查是否有启动图数据
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    startView_data_path = [cachesPath stringByAppendingPathComponent:@"CXHstarView_data.json"];
    NSFileManager* mgr = [NSFileManager defaultManager];
    if([mgr fileExistsAtPath:startView_data_path] == YES){//查看文件是否存在
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:startView_data_path];
        NSDictionary* startView_data_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        startView_data_dic = [startView_data_dic objectForKey:@"data"];
        
        //获取当前的时间戳
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval now_time=[dat timeIntervalSince1970];
        NSLog(@"当前的时间戳:%f",now_time);
        
        for (NSDictionary* dic in startView_data_dic) {
            //查找是否有需要显示的启动图
            if([[dic objectForKey:@"end_time"] doubleValue] > now_time && [[dic objectForKey:@"start_time"] doubleValue] < now_time){
                NSLog(@"%@",dic);
                //判断图片是否已加载
                NSURL* image_URL = [NSURL URLWithString:[dic objectForKey:@"image"]];
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                if ([manager diskImageExistsForURL:image_URL]) {
                    //刷新本地数据
                    [self download_startView_data];
                    return [[NSMutableDictionary alloc] initWithDictionary:dic];
                }
            }
        }
        
        
    }
    //刷新本地数据
    [self download_startView_data];
    return nil;
}


//下载数据
-(void)download_startView_data{
    //获取宽高的分辨率
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.bilibili.com/x/splash?build=3390&channel=appstore&height=%0.0f&plat=1&width=%0.0f",height*scale_screen,width*scale_screen]]];
    NSLog(@"%@",request.URL.absoluteString);
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;//忽略本地缓存数据
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error)
        {
            // NSLog(@"%@",data);
            //保存数据
            NSLog(@"写入启动图数据:%@",startView_data_path);
            [data writeToFile:startView_data_path atomically:YES];
            //预加载一遍视图
            NSDictionary* startView_data_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            startView_data_dic = [startView_data_dic objectForKey:@"data"];
            //获取当前的时间戳
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now_time=[dat timeIntervalSince1970];
            NSLog(@"当前的时间戳:%f",now_time);
            
            for (NSDictionary* dic in startView_data_dic) {
                //查找是否有需要预先下载显示的启动图
                if([[dic objectForKey:@"end_time"] doubleValue] > now_time){
                    NSURL* url = [NSURL URLWithString:[dic objectForKey:@"image"]];
                    UIImageView *imageview = [[UIImageView alloc] init];
                    [imageview sd_setImageWithURL:url];
                }
            }

        }
    
        //[session invalidateAndCancel];
   }] resume];

}
@end
