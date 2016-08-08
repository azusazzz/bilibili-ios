//
//  BangumiEntranceCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiEntranceEntity.h"

@interface BangumiEntranceCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) BangumiEntranceEntity *entrance;

+ (CGFloat)height;

@end
