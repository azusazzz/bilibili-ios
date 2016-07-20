//
//  VideoAndStatInfoCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoAndStatInfoCollectionViewCell.h"

@interface VideoAndStatInfoCollectionViewCell ()
{
    UILabel *_titleLabel;
    
    UIImageView *_viewIconImageView;
    UILabel *_viewCountLabel;
    
    UIImageView *_danmakuIconImageView;
    UILabel *_danmakuCountLabel;
    
    UILabel *_descLabel;
}
@end

@implementation VideoAndStatInfoCollectionViewCell

+ (CGSize)sizeForVideoInfo:(VideoInfoEntity *)videoInfo {
    return CGSizeMake(SSize.width, 0);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(13);
        [self addSubview:_titleLabel];
        
        _viewIconImageView = [[UIImageView alloc] init];
        _viewIconImageView.image = [UIImage imageNamed:@"misc_danmakuCount"];
        [self addSubview:_viewIconImageView];
        _viewCountLabel = [[UILabel alloc] init];
        _viewCountLabel.textColor = ColorWhite(146);
        _viewCountLabel.font = Font(10);
        [self addSubview:_viewCountLabel];
        
        _danmakuIconImageView = [[UIImageView alloc] init];
        _danmakuIconImageView.image = [UIImage imageNamed:@"misc_danmakuCount"];
        [self addSubview:_danmakuIconImageView];
        _danmakuCountLabel = [[UILabel alloc] init];
        _danmakuCountLabel.textColor = ColorWhite(146);
        _danmakuCountLabel.font = Font(10);
        [self addSubview:_danmakuCountLabel];
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = Font(12);
        _descLabel.textColor = ColorWhite(146);
        [self addSubview:_descLabel];
        
        
        
    }
    return self;
}


@end
