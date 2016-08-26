//
//  BangumiCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiCollectionView.h"

#import "BangumiEntranceHeaderView.h"
#import "BangumiEntranceFooterView.h"
#import "BangumiEntranceCollectionViewCell.h"

#import "BangumiLatestUpdateHeaderView.h"
#import "BangumiLatestUpdateCollectionViewCell.h"

#import "BangumiEndHeaderView.h"
#import "BangumiEndCollectionViewCell.h"

#import "BangumiRecommendHeaderView.h"
#import "BangumiRecommendCollectionViewCell.h"

@interface BangumiCollectionView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@end

@implementation BangumiCollectionView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = CRed;
        self.backgroundView.backgroundColor = ColorWhite(247);
        
        [self registerClass:[BangumiEntranceHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EntranceHeader"];
        [self registerClass:[BangumiEntranceFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"EntranceFooter"];
        [self registerClass:[BangumiEntranceCollectionViewCell class] forCellWithReuseIdentifier:@"Entrance"];
        
        [self registerClass:[BangumiLatestUpdateHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BangumiLatestUpdateHeader"];
        [self registerClass:[BangumiLatestUpdateCollectionViewCell class] forCellWithReuseIdentifier:@"BangumiLatest"];
        
        [self registerClass:[BangumiEndHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BangumiEndHeader"];
        [self registerClass:[BangumiEndCollectionViewCell class] forCellWithReuseIdentifier:@"BangumiEnd"];
        
        [self registerClass:[BangumiRecommendHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BangumiRecommendHeader"];
        [self registerClass:[BangumiRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"BangumiRecommend"];
        
    }
    return self;
}

- (void)setBangumiList:(BangumiListEntity *)bangumiList {
    _bangumiList = bangumiList;
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        !_handleDidSelectedBangumi ?: _handleDidSelectedBangumi(_bangumiList.latestUpdate[indexPath.row]);
    }
    else if (indexPath.section == 3) {
        !_handleDidSelectedRecommend ?: _handleDidSelectedRecommend(_bangumiList.recommends[indexPath.row]);
    }
}

#pragma mark - Number

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!_bangumiList) {
        return 0;
    }
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [_bangumiList.entrances count];
    }
    else if (section == 1) {
        return [_bangumiList.latestUpdate count];
    }
    else if (section == 2) {
        return 1;
    }
    else if (section == 3) {
        return [_bangumiList.recommends count];
    }
    else {
        return 0;
    }
}


#pragma mark - Size

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(15, 0, 0, 0);
    }
    else if (section == 1) {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
    else if (section == 2) {
        return UIEdgeInsetsMake(15, 0, 0, 0);
    }
    else if (section == 3) {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
    else {
        return UIEdgeInsetsZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SSize.width, [BangumiEntranceHeaderView heightForBanner:_bangumiList.banners width:SSize.width]);
    }
    else if (section == 1) {
        return CGSizeMake(SSize.width, [BangumiLatestUpdateHeaderView height]);
    }
    else if (section == 2) {
        return CGSizeMake(SSize.width, [BangumiEndHeaderView height]);
    }
    else if (section == 3) {
        return CGSizeMake(SSize.width, [BangumiRecommendHeaderView height]);
    }
    else {
        return CGSizeZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SSize.width, [BangumiEntranceFooterView height]);
    }
    else {
        return CGSizeZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SSize.width / 4, [BangumiEntranceCollectionViewCell height]);
    }
    else if (indexPath.section == 1) {
        CGFloat width = (SSize.width-15*3) / 2;
        return CGSizeMake(width, [BangumiLatestUpdateCollectionViewCell heightForWitdh:width]);
    }
    else if (indexPath.section == 2) {
        return CGSizeMake(SSize.width, [BangumiEndCollectionViewCell heightForWidth:SSize.width ends:_bangumiList.ends]);
    }
    else if (indexPath.section == 3) {
        return CGSizeMake(SSize.width-30, [BangumiRecommendCollectionViewCell heightForWidth:SSize.width-30 bangumiRecommend:_bangumiList.recommends[indexPath.row]]);
    }
    else {
        return CGSizeZero;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else if (section == 1) {
        return 15;
    }
    else if (section == 2) {
        return 0;
    }
    else if (section == 3) {
        return 15;
    }
    else {
        return 0;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else if (section == 1) {
        return 15;
    }
    else if (section == 2) {
        return 0;
    }
    else if (section == 3) {
        return 15;
    }
    else {
        return 0;
    }
}

#pragma mark - Cell

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EntranceHeader" forIndexPath:indexPath];
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EntranceFooter" forIndexPath:indexPath];
        }
    }
    else if (indexPath.section == 1) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BangumiLatestUpdateHeader" forIndexPath:indexPath];
        }
    }
    else if (indexPath.section == 2) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BangumiEndHeader" forIndexPath:indexPath];
        }
    }
    else if (indexPath.section == 3) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BangumiRecommendHeader" forIndexPath:indexPath];
        }
    }
    return NULL;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Entrance" forIndexPath:indexPath];
    }
    else if (indexPath.section == 1) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"BangumiLatest" forIndexPath:indexPath];
    }
    else if (indexPath.section == 2) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"BangumiEnd" forIndexPath:indexPath];
    }
    else if (indexPath.section == 3) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"BangumiRecommend" forIndexPath:indexPath];
    }
    return NULL;
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            ((BangumiEntranceHeaderView *)view).banners = _bangumiList.banners;
            ((BangumiEntranceHeaderView *)view).onClickBannerItem = _onClickBannerItem;
        }
    }
    else if (indexPath.section == 1) {
        if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [((BangumiLatestUpdateHeaderView *)view) setCount:_bangumiList.latestUpdate.count];
        }
    }
    [super collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ((BangumiEntranceCollectionViewCell *) cell).entrance = _bangumiList.entrances[indexPath.row];
    }
    else if (indexPath.section == 1) {
        [((BangumiLatestUpdateCollectionViewCell *) cell) setBangumi:_bangumiList.latestUpdate[indexPath.row]];
    }
    else if (indexPath.section == 2) {
        [((BangumiEndCollectionViewCell *) cell) setEnds:_bangumiList.ends];
        ((BangumiEndCollectionViewCell *) cell).handleDidSelectedBangumi = _handleDidSelectedBangumi;
    }
    else if (indexPath.section == 3) {
        [((BangumiRecommendCollectionViewCell *) cell) setBangumiRecommend:_bangumiList.recommends[indexPath.row]];
    }
    [super collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}


@end
