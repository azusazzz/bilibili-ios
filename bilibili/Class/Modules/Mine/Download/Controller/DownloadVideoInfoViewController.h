//
//  DownloadVideoInfoViewController.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadVideoEntity.h"

@interface DownloadVideoInfoViewController : UIViewController

@property (strong, nonatomic, readonly) DownloadVideoEntity *video;

- (instancetype)initWithDownloadVideo:(DownloadVideoEntity *)downloadVideo;

@end
