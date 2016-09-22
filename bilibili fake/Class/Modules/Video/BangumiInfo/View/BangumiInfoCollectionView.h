//
//  BangumiInfoCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiInfoEntity.h"

@interface BangumiInfoCollectionView : UICollectionView

@property (strong, nonatomic) BangumiInfoEntity *bangumiInfo;

/**
 *  选择番剧
 */
@property (copy, nonatomic) void (^selBangumiEpisode)(BangumiEpisodeEntity *bangumiEpisode);

/**
 *  选择番剧简介
 */
@property (copy, nonatomic) void (^selBangumiProfile)(void);

@end
