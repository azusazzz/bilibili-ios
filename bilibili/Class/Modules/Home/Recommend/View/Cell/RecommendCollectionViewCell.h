//
//  RecommendCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendBodyEntity.h"

/**
 *  推荐 Body模块 基类
 */
@interface RecommendCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) RecommendBodyEntity *body;


+ (CGFloat)heightForWidth:(CGFloat)width;

/**
 *  获取尺寸
 *
 *  @param width 显示区域宽度
 *
 *  @return 视图尺寸
 */
+ (CGSize)sizeForContentWidth:(CGFloat)width;

- (void)setBody:(RecommendBodyEntity *)body __attribute__((objc_requires_super));

- (void)showImageViewBottomGradient;

@end
