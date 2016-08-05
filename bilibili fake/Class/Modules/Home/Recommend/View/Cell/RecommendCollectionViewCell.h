//
//  RecommendCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendBodyEntity.h"

@interface RecommendCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) RecommendBodyEntity *body;

+ (CGFloat)heightForWidth:(CGFloat)width;

- (void)setBody:(RecommendBodyEntity *)body __attribute__((objc_requires_super));

- (void)showImageViewBottomGradient;

@end
