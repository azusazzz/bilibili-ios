//
//  RecommendAvCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendCollectionViewCell.h"

/**
 *  推荐 Body模块 分区
 */
@interface RecommendAvCollectionViewCell : RecommendCollectionViewCell

@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UIImageView *playCountImageView;
@property (strong, nonatomic) UILabel     *playCountLabel;
@property (strong, nonatomic) UIImageView *danmakuCountImageView;
@property (strong, nonatomic) UILabel     *danmakuCountLabel;

@end
