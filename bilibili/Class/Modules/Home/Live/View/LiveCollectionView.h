//
//  LiveCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListEntity.h"
#import "RefreshCollectionView.h"

@interface LiveCollectionView : RefreshCollectionView

@property (strong, nonatomic) LiveListEntity *liveList;

@property (strong, nonatomic) void (^handleDidSelectedItem)(NSIndexPath *indexPath);

@property (strong, nonatomic) void (^handleDidSelectedLive)(LiveListPartitionLiveEntity *live);

@property (strong, nonatomic) void (^onClickBannerItem)(LiveListBannerEntity *banner);

@end
