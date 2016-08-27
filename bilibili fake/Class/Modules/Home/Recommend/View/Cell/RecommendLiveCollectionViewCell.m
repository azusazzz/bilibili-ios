//
//  RecommendLiveCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendLiveCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface RecommendLiveCollectionViewCell ()
{
    UIImageView *_ownerFaceView;
    UILabel     *_ownerNameLabel;
    UILabel     *_onlineLabel;
    UILabel     *_titleLabel;
}
@end

@implementation RecommendLiveCollectionViewCell

+ (CGSize)sizeForContentWidth:(CGFloat)width {
    CGFloat itemWidth = (width - 15*3) / 2;
    return CGSizeMake(itemWidth, itemWidth * 0.625 + 20 + 6+16);
}

- (void)setBody:(RecommendBodyEntity *)body {
    [super setBody:body];
    [_ownerFaceView sd_setImageWithURL:[NSURL URLWithString:body.face]];
    _ownerNameLabel.text = body.name;
    _onlineLabel.text = [NSString stringWithFormat:@"%ld", body.online];
    _titleLabel.text = body.title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _ownerFaceView = [[UIImageView alloc] init];
        _ownerFaceView.layer.cornerRadius = 20;
        _ownerFaceView.layer.masksToBounds = YES;
        [self.contentView addSubview:_ownerFaceView];
        _ownerNameLabel = [[UILabel alloc] init];
        _ownerNameLabel.font = Font(12);
        _ownerNameLabel.textColor = ColorWhite(34);
        [self.contentView addSubview:_ownerNameLabel];
        
        _onlineLabel = [[UILabel alloc] init];
        _onlineLabel.textAlignment = NSTextAlignmentCenter;
        _onlineLabel.font = Font(11);
        _onlineLabel.textColor = ColorWhite(34);
        _onlineLabel.backgroundColor = ColorWhite(230);
        _onlineLabel.layer.cornerRadius = 4;
        _onlineLabel.layer.masksToBounds = YES;
        _onlineLabel.layer.borderColor = ColorWhite(200).CGColor;
        _onlineLabel.layer.borderWidth = 0.5;
        [self addSubview:_onlineLabel];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(11);
        _titleLabel.textColor = ColorWhite(146);
        [self addSubview:_titleLabel];
        
        
        [_ownerFaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 40;
            make.height.offset = 40;
            make.left.offset = 5;
            make.centerY.equalTo(self.imageView.mas_bottom);
        }];
        [_ownerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ownerFaceView.mas_right).offset = 5;
            make.height.offset = 14;
            make.right.offset = -5;
            make.bottom.equalTo(_ownerFaceView);
        }];
        [_onlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.width.offset = 45;
            make.height.offset = 16;
            make.top.equalTo(_ownerFaceView.mas_bottom).offset = 6;
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ownerNameLabel);
            make.right.equalTo(_ownerNameLabel);
            make.height.offset = 16;
            make.centerY.equalTo(_onlineLabel);
        }];
        
    }
    return self;
}

@end
