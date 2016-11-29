//
//  DownloadVideoTableView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadVideoEntity.h"

@interface DownloadVideoTableView : UITableView

@property (strong, nonatomic) NSArray<DownloadVideoEntity *> *list;

@property (copy, nonatomic) void (^selectedVideo)(DownloadVideoEntity *video);

@property (copy, nonatomic) void (^delHistory)(DownloadVideoEntity *history);

@end
