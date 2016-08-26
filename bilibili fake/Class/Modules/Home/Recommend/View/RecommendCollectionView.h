//
//  RecommendCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RefreshCollectionView.h"
#import "RecommendEntity.h"

@interface RecommendCollectionView : RefreshCollectionView

@property (strong, nonatomic) NSArray<RecommendEntity *> *list;


@property (strong, nonatomic) void (^handleDidSelectedItem)(NSIndexPath *indexPath);

/**
 *  点击Banner
 */
@property (strong, nonatomic) void (^onClickBannerItem)(RecommendBannerEntity *banner);

@end
