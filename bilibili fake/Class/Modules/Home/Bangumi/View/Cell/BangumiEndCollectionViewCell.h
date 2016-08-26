//
//  BangumiEndCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiEntity.h"

@interface BangumiEndCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSArray<BangumiEntity *> *ends;

@property (copy, nonatomic) void (^handleDidSelectedBangumi)(BangumiEntity *bangumi);

+ (CGFloat)heightForWidth:(CGFloat)width ends:(NSArray<BangumiEntity *> *)ends;

@end
