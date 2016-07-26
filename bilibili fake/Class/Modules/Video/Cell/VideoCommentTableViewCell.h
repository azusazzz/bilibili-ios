//
//  VideoCommentTableViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/26.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoCommentItemEntity.h"

@interface VideoCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *topLine;

+ (CGFloat)heightForComment:(VideoCommentItemEntity *)comment showReply:(BOOL)showReply;

- (void)setupCommentInfo:(VideoCommentItemEntity *)comment showReply:(BOOL)showReply;

@end
