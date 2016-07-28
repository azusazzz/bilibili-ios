//
//  HomeRecommendFooterView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRecommendEntity.h"

@interface HomeRecommendFooterView : UICollectionReusableView

+ (CGFloat)heightForBanner:(NSArray<HomeRecommendBannerEntity *> *)banner width:(CGFloat)width;

- (void)setBanner:(NSArray<HomeRecommendBannerEntity *> *)banner;

@end
