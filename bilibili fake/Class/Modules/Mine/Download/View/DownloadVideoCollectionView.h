//
//  DownloadVideoCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadVideoEntity.h"

@interface DownloadVideoCollectionView : UICollectionView

@property (strong, nonatomic) NSArray<DownloadVideoEntity *> *list;

@property (strong, nonatomic) void (^selectedVideo)(DownloadVideoEntity *video);

@end
