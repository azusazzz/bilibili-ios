//
//  VideoRangTableView.m
//  bilibili fake
//
//  Created by cxh on 16/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRangTableView.h"
#import "VideoRangData.h"
#import <UIImageView+WebCache.h>
#import "VideoCell.h"
#import "VideoViewController.h"

@interface VideoRangTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation VideoRangTableView{
    NSDictionary* VideoListData;
    NSString* _title;
}

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        _title = title;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        VideoListData = @{};

    }
    return self;
}

- (void)setData{
    if (VideoListData.count) return;
    
    [[[VideoRangData alloc] init] getRangData:_title block:^(NSMutableDictionary *data) {
        VideoListData = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }];
}

- (void)dealloc {
    [[SDImageCache sharedImageCache] clearMemory];//清理内存中的
    NSLog(@"%s", __FUNCTION__);
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;  
}
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ranking = [NSString stringWithFormat:@"%lu",indexPath.row];
    NSMutableDictionary* dic = [VideoListData objectForKey:ranking];
    [[self viewController].navigationController pushViewController:[[VideoViewController alloc] initWithAid:[[dic objectForKey:@"aid"] integerValue]] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return VideoListData.count?20:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //普通视频
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    if (!cell) {
        NSString *ranking = [NSString stringWithFormat:@"%lu",indexPath.row];
        NSMutableDictionary* dic = [VideoListData objectForKey:ranking];
        ranking = [NSString stringWithFormat:@"%lu",indexPath.row+1];
        [dic setObject:ranking forKey:@"ranking"];
        cell = [[VideoCell alloc] initWithData:dic order:@""];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
