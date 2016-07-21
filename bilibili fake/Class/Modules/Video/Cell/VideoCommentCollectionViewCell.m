//
//  VideoCommentCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentCollectionViewCell.h"

@interface VideoCommentCollectionViewCell ()
{
    UIImageView *_faceImageView;
    UIImageView *_levelImageView;
    UILabel *_nicknameLabel;
    UIImageView *_sexImageView;
    UILabel *_lvAndDateLabel;
    UILabel *_msgLabel;
    UIImageView *_replyIconImageView;
    UILabel *_replyCountLabel;
    UIButton *_goodButton;
    UILabel *_goodCountLabel;
}
@end

@implementation VideoCommentCollectionViewCell

- (void)setupCommentInfo:(VideoCommentItemEntity *)comment {
    
}

+ (CGSize)sizeForComment:(VideoCommentItemEntity *)comment {
    return CGSizeMake(SSize.width, 80);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _faceImageView = [[UIImageView alloc] init];
        [self addSubview:_faceImageView];
        _levelImageView = [[UIImageView alloc] init];
        [self addSubview:_levelImageView];
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = ColorWhite(186);
        _nicknameLabel.font = Font(11);
        [self addSubview:_nicknameLabel];
        _sexImageView = [[UIImageView alloc] init];
        [self addSubview:_sexImageView];
        
        
    }
    return self;
}

@end
