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



@interface BangumiCollectionView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@end

@implementation BangumiCollectionView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundColor = CRed;
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = ColorWhite(247);
//        self.backgroundView.layer.cornerRadius = 6;
//        self.backgroundView.layer.masksToBounds = YES;
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[BangumiEntranceHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EntranceHeader"];
        [self registerClass:[BangumiEntranceFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"EntranceFooter"];
        [self registerClass:[BangumiEntranceCollectionViewCell class] forCellWithReuseIdentifier:@"Entrance"];
        
//        [self registerClass:[LivePartitionsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LiveHeader"];
//        [self registerClass:[LivePartitionsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LiveFooter"];
//        [self registerClass:[LiveCollectionViewCell class] forCellWithReuseIdentifier:@"Live"];
        
    }
    return self;
}

- (void)setBangumiList:(BangumiListEntity *)bangumiList {
    _bangumiList = bangumiList;
    [self reloadData];
}


/**
 *  Number
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!_bangumiList) {
        return 0;
    }
    return 1;
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


/**
 *  Size
 */
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
    else {
        return CGSizeZero;
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
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EntranceHeader" forIndexPath:indexPath];
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EntranceFooter" forIndexPath:indexPath];
        }
    }
    return NULL;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"Entrance" forIndexPath:indexPath];
    }
    return NULL;
}

/**
 *  Data
 */
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            ((BangumiEntranceHeaderView *)view).banners = _bangumiList.banners;
        }
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ((BangumiEntranceCollectionViewCell *) cell).entrance = _bangumiList.entrances[indexPath.row];
    }
}


@end
