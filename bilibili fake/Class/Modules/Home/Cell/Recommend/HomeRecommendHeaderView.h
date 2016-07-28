//
//  HomeRecommendHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRecommendEntity.h"

@interface HomeRecommendHeaderView : UICollectionReusableView

//@property (strong, nonatomic) HomeRecommendEntity *recommend;



+ (CGFloat)heightForRecommend:(HomeRecommendEntity *)recommend width:(CGFloat)width;

- (void)setRecommend:(HomeRecommendEntity *)recommend;


@end
