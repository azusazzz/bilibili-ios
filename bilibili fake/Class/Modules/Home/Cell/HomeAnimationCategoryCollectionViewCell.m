//
//  HomeAnimationCategoryCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationCategoryCollectionViewCell.h"

@interface HomeAnimationCategoryCollectionViewCell ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UILabel *_leftTitleLabel;
    UILabel *_rightTitleLabel;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
    
    UICollectionView *_collectionView;
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
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
//        [_collectionView registerClass:[HomeAnimationCategoryCollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
        _collectionView.backgroundColor = ColorWhite(240);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.top.offset = 15;
            make.width.offset = 20;
            make.height.offset = 20;
        }];
        [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset = 5;
            make.top.offset = 15;
            make.height.offset = 20;
            make.width.offset = 100;
        }];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.top.offset = 15;
            make.width.offset = 20;
            make.height.offset = 20;
        }];
        [_rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightImageView.mas_left).offset = -5;
            make.top.offset = 15;
            make.height.offset = 20;
            make.width.offset = 100;
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setCategoryEntity:(HomeAnimationCategoryEntity *)categoryEntity; {
    _categoryEntity = categoryEntity;
    
    _leftTitleLabel.text = _categoryEntity.tag_name;
}


@end
