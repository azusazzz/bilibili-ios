//
//  RegionShowChildCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/1.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowChildCollectionView.h"

#import "RegionShowHeaderView.h"
#import "RegionShowChildCollectionViewCell.h"

@implementation RegionShowChildCollectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = CRed;
        self.backgroundView.backgroundColor = ColorWhite(247);
        
        [self registerClass:[RegionShowHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self registerClass:[RegionShowChildCollectionViewCell class] forCellWithReuseIdentifier:@"Video"];
        
    }
    return self;
}

- (void)setRegionShowChild:(RegionShowChildEntity *)regionShowChild {
    if (!regionShowChild && !_regionShowChild) {
        return;
    }
    _regionShowChild = regionShowChild;
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        !_handleDidSelectedVideo ?: _handleDidSelectedVideo(_regionShowChild.recommends[indexPath.row]);
    }
    else if (indexPath.section == 1) {
        !_handleDidSelectedVideo ?: _handleDidSelectedVideo(_regionShowChild.news[indexPath.row]);
    }
}

#pragma mark - Number

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_regionShowChild.recommends count];
        case 1:
            return [_regionShowChild.news count];
        default:
            return 0;
    }
}

#pragma mark - Size

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SSize.width, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SSize.width, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
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
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Video" forIndexPath:indexPath];
}


#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        [((RegionShowChildCollectionViewCell *)cell) setVideo:_regionShowChild.recommends[indexPath.row]];
    }
    else if (indexPath.section == 1) {
        [((RegionShowChildCollectionViewCell *)cell) setVideo:_regionShowChild.news[indexPath.row]];
    }
}

@end
