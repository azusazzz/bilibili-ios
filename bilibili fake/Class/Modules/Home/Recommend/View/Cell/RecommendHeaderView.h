//
//  RecommendHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendEntity.h"

@interface RecommendHeaderView : UICollectionReusableView

+ (CGFloat)heightForRecommend:(RecommendEntity *)recommend width:(CGFloat)width;

- (void)setRecommend:(RecommendEntity *)recommend;

@end
