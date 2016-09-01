//
//  RegionShowRecommendCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RefreshCollectionView.h"
#import "RegionShowRecommendEntity.h"

@interface RegionShowRecommendCollectionView : RefreshCollectionView

@property (strong, nonatomic, readonly) RegionShowRecommendEntity *regionShow;


@property (strong, nonatomic) void (^onClickBannerItem)(RegionShowBannerEntity *banner);

@property (strong, nonatomic) void (^handleDidSelectedVideo)(RegionShowVideoEntity *video);

@end
