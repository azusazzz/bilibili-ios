//
//  HomeAnimationCategoryCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationCategoryCollectionViewCell.h"
#import "HomeAnimationCategoryItemCollectionViewCell.h"

#define CategoryItemIdentifier @"CategoryItemIdentifier"

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

+ (CGSize)size; {
    return CGSizeMake(SSize.width, 15+20+15 + [HomeAnimationCategoryItemCollectionViewCell size].height);
}


- (instancetype)initWithFrame:(CGRect)frame; {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.font = Font(14);
        _leftTitleLabel.textColor = ColorWhite(34);
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
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = [HomeAnimationCategoryItemCollectionViewCell size];
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        [_collectionView registerClass:[HomeAnimationCategoryItemCollectionViewCell class] forCellWithReuseIdentifier:CategoryItemIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
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
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_leftImageView.mas_bottom).offset = 15;
            make.bottom.offset = 0;
        }];
    }
    return self;
}

- (void)setCategoryEntity:(HomeAnimationCategoryEntity *)categoryEntity; {
    _categoryEntity = categoryEntity;
    
    _leftTitleLabel.text = _categoryEntity.tag_name;
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView; {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _categoryEntity.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return [collectionView dequeueReusableCellWithReuseIdentifier:CategoryItemIdentifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(HomeAnimationCategoryItemCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath; {
    cell.categoryItemEntity = _categoryEntity.list[indexPath.row];
}

//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
//    return [HomeAnimationCategoryItemCollectionViewCell size];
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section; {
//    return 15;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section; {
//    return 0;
//}


@end
