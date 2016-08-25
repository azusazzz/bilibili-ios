//
//  LiveCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveCollectionView.h"

#import "LiveListBannerView.h"
#import "LiveEntranceFooterView.h"
#import "LiveEntranceCollectionViewCell.h"

#import "LivePartitionsHeaderView.h"
#import "LivePartitionsFooterView.h"
#import "LiveCollectionViewCell.h"


@interface LiveCollectionView ()


@end

@implementation LiveCollectionView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = CRed;
//        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = ColorWhite(247);
        
        [self registerClass:[LiveListBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Banner"];
        [self registerClass:[LiveEntranceFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"EntranceFooter"];
        [self registerClass:[LiveEntranceCollectionViewCell class] forCellWithReuseIdentifier:@"Entrance"];
        
        [self registerClass:[LivePartitionsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LiveHeader"];
        [self registerClass:[LivePartitionsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LiveFooter"];
        [self registerClass:[LiveCollectionViewCell class] forCellWithReuseIdentifier:@"Live"];
        
    }
    return self;
}

- (void)setLiveList:(LiveListEntity *)liveList {
    _liveList = liveList;
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }
    else {
        LiveListPartitionLiveEntity *live = _liveList.partitions[indexPath.section-1].lives[indexPath.row];
        _handleDidSelectedLive ? _handleDidSelectedLive(live) : NULL;
    }
    
}

/**
 *  Number
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!_liveList) {
        return 0;
    }
    return 1 + [_liveList.partitions count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [_liveList.entranceIcons count];
    }
    else {
        NSInteger count = [_liveList.partitions[section-1].lives count];
        return count > 4 ? 4 : count;
    }
}

/**
 *  Size
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(15, 0, 0, 0);
    }
    else {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SSize.width, [LiveListBannerView heightForBanner:_liveList.banner width:SSize.width]);
    }
    else {
        return CGSizeMake(SSize.width, [LivePartitionsHeaderView height]);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SSize.width, [LiveEntranceFooterView height]);
    }
    else {
        return CGSizeMake(SSize.width, [LivePartitionsFooterView height]);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SSize.width / 4, [LiveEntranceCollectionViewCell height]);
    }
    else {
        CGFloat width = (SSize.width-15*3) / 2;
        return CGSizeMake(width, [LiveCollectionViewCell heightForWitdh:width]);
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

/**
 *  Cell
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Banner" forIndexPath:indexPath];
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EntranceFooter" forIndexPath:indexPath];
        }
    }
    else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LiveHeader" forIndexPath:indexPath];
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LiveFooter" forIndexPath:indexPath];
        }
    }
    return NULL;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Entrance" forIndexPath:indexPath];
    }
    else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Live" forIndexPath:indexPath];
    }
}


/**
 *  Data
 */
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            ((LiveListBannerView *)view).banner = _liveList.banner;
            ((LiveListBannerView *)view).onClickBannerItem = _onClickBannerItem;
        }
    }
    else {
        if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            ((LivePartitionsHeaderView *)view).partition = _liveList.partitions[indexPath.section-1];
        }
    }
    [super collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ((LiveEntranceCollectionViewCell *) cell).entrance = _liveList.entranceIcons[indexPath.row];
    }
    else {
        ((LiveCollectionViewCell *) cell).live = _liveList.partitions[indexPath.section-1].lives[indexPath.row];
    }
    [super collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}


@end
