//
//  VideoIntroTagsCollectionViewCell.h
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoIntroTagsCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) void (^onClickTag)(NSString *tag);

+ (CGFloat)heightForWidth:(CGFloat)width tags:(NSArray<NSString *> *)tags;

- (void)setTags:(NSArray<NSString *> *)tags;

@end
