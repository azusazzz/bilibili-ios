//
//  BangumiEpisodesHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiInfoEntity.h"

/**
 *  选集
 */
@interface BangumiEpisodesHeaderView : UICollectionReusableView

@property (strong, nonatomic) BangumiInfoEntity *bangumiInfo;

+ (NSString *)Identifier;

+ (CGSize)size;

@end
