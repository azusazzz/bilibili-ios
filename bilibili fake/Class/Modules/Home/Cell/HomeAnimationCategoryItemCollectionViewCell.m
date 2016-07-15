//
//  HomeAnimationCategoryItemCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationCategoryItemCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface HomeAnimationCategoryItemCollectionViewCell ()

{
    UIImageView *_coverImageView;
    UILabel *_titleLabel;
    UILabel *_totalCountLabel;
}

@end

@implementation HomeAnimationCategoryItemCollectionViewCell

+ (CGSize)size; {
    CGFloat height = 170;
    return CGSizeMake(height*240.0/320.0, height +5+14 +5+12 + 15);
}

- (instancetype)initWithFrame:(CGRect)frame; {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _coverImageView = [[UIImageView alloc] init];
        [self addSubview:_coverImageView];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textColor = ColorWhite(34);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _totalCountLabel = [[UILabel alloc] init];
        _totalCountLabel.font = Font(10);
        _totalCountLabel.textColor = ColorRGB(219, 92, 92);
        _totalCountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_totalCountLabel];
        
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(_coverImageView.mas_width).with.multipliedBy(320.0/240.0);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_coverImageView.mas_bottom).offset = 5;
            make.height.offset = 14;
        }];
        [_totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_titleLabel.mas_bottom).offset = 5;
            make.height.offset = 12;
        }];
        
    }
    return self;
}

- (void)setCategoryItemEntity:(HomeAnimationCategoryItemEntity *)categoryItemEntity; {
    _categoryItemEntity = categoryItemEntity;
    
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_categoryItemEntity.cover] placeholderImage:NULL];
    _titleLabel.text = _categoryItemEntity.title;
    
    if (_categoryItemEntity.is_finish) {
        _totalCountLabel.text = [NSString stringWithFormat:@"%ld话全", _categoryItemEntity.total_count];
    }
    else {
        _totalCountLabel.text = [NSString stringWithFormat:@"%ld话连载", _categoryItemEntity.total_count];
    }
    
}

@end
