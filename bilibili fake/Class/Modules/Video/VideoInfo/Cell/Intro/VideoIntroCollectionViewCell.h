//
//  VideoIntroCollectionViewCell.h
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoInfoEntity.h"

@interface VideoIntroCollectionViewCell : UICollectionViewCell

+ (CGFloat)heightForWidth:(CGFloat)width videoInfo:(VideoInfoEntity *)videoInfo showAllDesc:(BOOL)showAllDesc;

- (void)setVideoInfo:(VideoInfoEntity *)videoInfo showAllDesc:(BOOL)showAllDesc;

@end
