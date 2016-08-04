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

- (void)setHistory:(HistoryEntity *)history;

@end
