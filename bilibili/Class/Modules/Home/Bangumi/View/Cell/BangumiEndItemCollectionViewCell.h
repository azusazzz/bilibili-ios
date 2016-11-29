//
//  BangumiEndItemCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangumiEntity.h"

@interface BangumiEndItemCollectionViewCell : UICollectionViewCell

- (void)setBangumi:(BangumiEntity *)bangumi;

+ (CGFloat)heightForWitdh:(CGFloat)width;

@end
