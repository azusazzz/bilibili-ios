//
//  HistoryCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryEntity.h"

@interface HistoryCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIView *bottomLine;

@property (strong, nonatomic) UIImageView *picImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *ownerLabel;
@property (strong, nonatomic) UILabel *viewCountLabel;
@property (strong, nonatomic) UILabel *danmakuCountLabel;

- (void)setHistory:(HistoryEntity *)history;

@end
