//
//  RecommendFooterView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendBannerEntity.h"

@interface RecommendFooterView : UICollectionReusableView

@property (strong, nonatomic) void (^onClickBannerItem)(RecommendBannerEntity *banner);

+ (CGFloat)heightForBanner:(NSArray<RecommendBannerEntity *> *)banner width:(CGFloat)width;

- (void)setBanner:(NSArray<RecommendBannerEntity *> *)banner;

@end
