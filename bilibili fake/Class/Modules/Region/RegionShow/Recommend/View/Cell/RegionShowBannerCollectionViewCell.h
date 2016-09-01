//
//  RegionShowBannerCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/31.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionShowBannerEntity.h"

@interface RegionShowBannerCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) NSArray<RegionShowBannerEntity *> *banners;

@property (strong, nonatomic) void (^onClickBannerItem)(RegionShowBannerEntity *banner);


+ (CGSize)sizeForWidth:(CGFloat)width;

@end
