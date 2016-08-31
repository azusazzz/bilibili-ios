//
//  RegionShowRecommendCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowRecommendCollectionView.h"
#import "RegionShowHeaderView.h"

#import "RegionShowBannerCollectionViewCell.h"
#import "RegionShowAvCollectionViewCell.h"


@implementation RegionShowRecommendCollectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = CRed;
        self.backgroundView.backgroundColor = ColorWhite(247);
        
        [self registerClass:[RegionShowHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self registerClass:[RegionShowBannerCollectionViewCell class] forCellWithReuseIdentifier:@"Banner"];
        [self registerClass:[RegionShowAvCollectionViewCell class] forCellWithReuseIdentifier:@"Video"];
        
    }
    return self;
}

- (void)setRegionShow:(RegionShowRecommendEntity *)regionShow {
    if (!regionShow && !_regionShow) {
        return;
    }
    _regionShow = regionShow;
    [self reloadData];
}


#pragma mark - Number

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_regionShow.banners count] ? 1 : 0;
        case 1:
            return [_regionShow.recommends count];
        case 2:
            return [_regionShow.news count];
        case 3:
            return [_regionShow.dynamics count];
        default:
            return 0;
    }
}

#pragma mark - Size

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    else {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }
    else {
        return CGSizeMake(SSize.width, 50);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SSize.width, 100);
    }
    else {
        return [RegionShowAvCollectionViewCell sizeForContentWidth:SSize.width];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 15;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 15;
    }
}

#pragma mark - Cell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    }
    else {
        return NULL;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Banner" forIndexPath:indexPath];
    }
    else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Video" forIndexPath:indexPath];
    }
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        
    }
    else if (indexPath.section == 1) {
        
    }
    else if (indexPath.section == 2) {
        
    }
    else if (indexPath.section == 3) {
        
    }
}


@end
