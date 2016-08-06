//
//  LiveEntranceCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListEntranceEntity.h"

@interface LiveEntranceCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) LiveListEntranceEntity *entrance;

+ (CGFloat)height;


@end
