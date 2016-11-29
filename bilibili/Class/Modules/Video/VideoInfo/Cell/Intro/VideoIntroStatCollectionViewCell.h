//
//  VideoIntroStatCollectionViewCell.h
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoIntroStatCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) void (^onClickDownload)(void);

+ (CGFloat)height;

@end
