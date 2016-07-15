//
//  HomeAnimationCategoryCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationCategoryCollectionViewCell.h"

@interface HomeAnimationCategoryCollectionViewCell ()
{
    UILabel *_leftTitleLabel;
    UILabel *_rightTitleLabel;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
}
@end

@implementation HomeAnimationCategoryCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame; {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.font = Font(14);
        [self addSubview:_leftTitleLabel];
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"home_icon_defult"];
        [self addSubview:_leftImageView];
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.text = @"进去看看";
        _rightTitleLabel.font = Font(14);
        _rightTitleLabel.textColor = ColorWhite(146);
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightTitleLabel];
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"home_icon_defult"];
        [self addSubview:_rightImageView];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 10;
            make.width.offset = 20;
            make.height.offset = 20;
        }];
        [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset = 5;
            make.top.offset = 10;
            make.height.offset = 20;
            make.width.offset = 100;
        }];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -10;
            make.top.offset = 10;
            make.width.offset = 20;
            make.height.offset = 20;
        }];
        [_rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightImageView.mas_left).offset = -5;
            make.top.offset = 10;
            make.height.offset = 20;
            make.width.offset = 100;
        }];
        
    }
    return self;
}

- (void)setCategoryEntity:(HomeAnimationCategoryEntity *)categoryEntity; {
    _categoryEntity = categoryEntity;
    
    _leftTitleLabel.text = _categoryEntity.tag_name;
}


@end
