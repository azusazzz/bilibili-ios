//
//  VideoIntroPagesCollectionViewCell.h
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPageInfoEntity.h"

@interface VideoIntroPagesCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSArray<VideoPageInfoEntity *> *pages;

@property (copy, nonatomic) void (^onClickPageItem)(NSInteger idx);


+ (CGFloat)heightWithPages:(NSArray<VideoPageInfoEntity *> *)pages;

@end
