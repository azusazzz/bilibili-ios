//
//  BangumiRecommendCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiRecommendEntity.h"

@interface BangumiRecommendCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) BangumiRecommendEntity *bangumiRecommend;

+ (CGFloat)heightForWidth:(CGFloat)width bangumiRecommend:(BangumiRecommendEntity *)bangumiRecommend;

@end
