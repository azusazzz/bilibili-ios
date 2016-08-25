//
//  BangumiEntranceHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiBannerEntity.h"

@interface BangumiEntranceHeaderView : UICollectionReusableView

@property (strong, nonatomic) NSArray<BangumiBannerEntity *> *banners;

@property (strong, nonatomic) void (^onClickBannerItem)(BangumiBannerEntity *banner);

+ (CGFloat)heightForBanner:(NSArray<BangumiBannerEntity *> *)banner width:(CGFloat)width;

@end
