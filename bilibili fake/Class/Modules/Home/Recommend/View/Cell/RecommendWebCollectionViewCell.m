//
//  RecommendWebCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendWebCollectionViewCell.h"

@implementation RecommendWebCollectionViewCell

+ (CGSize)sizeForContentWidth:(CGFloat)width {
    CGFloat itemWidth = width - 30;
    return CGSizeMake(itemWidth, width * 300.0 / 520.0);
}

@end
