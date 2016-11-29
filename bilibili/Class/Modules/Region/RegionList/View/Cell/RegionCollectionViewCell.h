//
//  RegionCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionEntity.h"

@interface RegionCollectionViewCell : UICollectionViewCell

+ (CGFloat)heightForWidth:(CGFloat)width;

- (void)setRegion:(RegionEntity *)region;

@end
