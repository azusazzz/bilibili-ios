//
//  HomeRecommendCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRecommendEntity.h"

@interface HomeRecommendCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) HomeRecommendBodyEntity *body;

//@property (assign, nonatomic) BOOL showImageViewBottomGradient;


+ (CGFloat)heightForWidth:(CGFloat)width;

- (void)setBody:(HomeRecommendBodyEntity *)body __attribute__((objc_requires_super));

- (void)showImageViewBottomGradient;

@end
