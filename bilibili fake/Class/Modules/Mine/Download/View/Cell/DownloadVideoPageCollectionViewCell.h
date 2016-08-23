//
//  DownloadVideoPageCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadVideoPageEntity.h"

@interface DownloadVideoPageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) DownloadVideoPageEntity *videoPage;

+ (CGFloat)height;

@end
