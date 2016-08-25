//
//  LiveListBannerView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListBannerEntity.h"

@interface LiveListBannerView : UICollectionReusableView

@property (strong, nonatomic) NSArray<LiveListBannerEntity *> *banner;

@property (strong, nonatomic) void (^onClickBannerItem)(LiveListBannerEntity *banner);

+ (CGFloat)heightForBanner:(NSArray<LiveListBannerEntity *> *)banner width:(CGFloat)width;

@end
