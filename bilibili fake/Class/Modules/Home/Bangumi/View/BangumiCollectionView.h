//
//  BangumiCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RefreshCollectionView.h"
#import "BangumiListEntity.h"

@interface BangumiCollectionView : RefreshCollectionView

@property (strong, nonatomic) BangumiListEntity *bangumiList;

@property (strong, nonatomic) void (^onClickBannerItem)(BangumiBannerEntity *banner);

@property (copy, nonatomic) void (^handleDidSelectedBangumi)(BangumiEntity *bangumi);

@property (copy, nonatomic) void (^handleDidSelectedRecommend)(BangumiRecommendEntity *recommend);

@end
