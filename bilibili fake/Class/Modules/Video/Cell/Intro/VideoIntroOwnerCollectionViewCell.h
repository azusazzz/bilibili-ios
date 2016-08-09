//
//  VideoIntroOwnerCollectionViewCell.h
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoOwnerInfoEntity.h"

@interface VideoIntroOwnerCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) VideoOwnerInfoEntity *ownerInfo;

+ (CGFloat)height;

- (void)setOwnerInfo:(VideoOwnerInfoEntity *)ownerInfo pubdate:(NSTimeInterval)pubdate;

@end
