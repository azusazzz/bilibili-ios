//
//  VideoCommentCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoCommentItemEntity.h"

@interface VideoCommentCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIView *topLine;

+ (CGSize)sizeForComment:(VideoCommentItemEntity *)comment;

- (void)setupCommentInfo:(VideoCommentItemEntity *)comment;

@end
