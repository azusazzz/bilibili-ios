//
//  DownloadVideoSelectView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoInfoEntity.h"

@interface DownloadVideoSelectView : UIView

+ (instancetype)showWithVideoInfo:(VideoInfoEntity *)videoInfo;

@end
