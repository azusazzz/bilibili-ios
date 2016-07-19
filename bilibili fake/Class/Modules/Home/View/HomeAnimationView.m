//
//  HomeAnimationView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationView.h"
#import "HomeAnimationRequest.h"
#import "HomeAnimationModel.h"
#import "HomeAnimationCategoryCollectionViewCell.h"

#define ReuseIdentifier @"AnimationCategory"

@interface HomeAnimationView ()
<RequestDelegate,
UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    HomeAnimationModel *_model;
    UICollectionView *_collectionView;
}

@end

@implementation HomeAnimationView

- (instancetype)init; {
    self = [super init];
    if (!self) {
        return self;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [_collectionView registerClass:[HomeAnimationCategoryCollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    _collectionView.backgroundColor = ColorWhite(240);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    _model = [[HomeAnimationModel alloc] init];
    
    
    [[HomeAnimationRequest request] startWithDelegate:self];
//    [[HomeAnimationRequest requestWithDelegate:self] start];
    
    return self;
}


#pragma mark - ESRequestDelegate

- (void)requestCompletion:(Request *)request; {
    
    
    [_model setCategoryJSONObject:request.responseObject];
    
    [_collectionView reloadData];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView; {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _model.categoryEntitys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(HomeAnimationCategoryCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath; {
    cell.categoryEntity = _model.categoryEntitys[indexPath.row];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return [HomeAnimationCategoryCollectionViewCell size];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section; {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section; {
    return 10;
}



@end
