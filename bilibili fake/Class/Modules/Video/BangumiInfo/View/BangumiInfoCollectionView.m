//
//  BangumiInfoCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoCollectionView.h"

#import "BangumiInfoHeaderView.h"

#import "BangumiEpisodesHeaderView.h"
#import "BangumiEpisodeCollectionViewCell.h"

#import "BangumiProfileCollectionViewCell.h"

@interface BangumiInfoCollectionView ()
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation BangumiInfoCollectionView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = ColorWhite(247);
        self.alwaysBounceVertical = NO;
        [self registerClass:[BangumiInfoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BangumiInfoHeaderView.Identifier];
        
        [self registerClass:[BangumiEpisodesHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BangumiEpisodesHeaderView.Identifier];
        [self registerClass:[BangumiEpisodeCollectionViewCell class] forCellWithReuseIdentifier:[BangumiEpisodeCollectionViewCell Identifier]];
        
        [self registerClass:BangumiProfileCollectionViewCell.class forCellWithReuseIdentifier:BangumiProfileCollectionViewCell.Identifier];
    }
    return self;
}

- (void)setBangumiInfo:(BangumiInfoEntity *)bangumiInfo {
    _bangumiInfo = bangumiInfo;
    [self reloadData];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        !_selBangumiEpisode ?: _selBangumiEpisode(_bangumiInfo.episodes[indexPath.row]);
    }
    else if (indexPath.section == 2) {
        !_selBangumiProfile ?: _selBangumiProfile();
    }
}

#pragma mark - Number
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!_bangumiInfo) {
        return 0;
    }
    return 3; // 5
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0; //[_bangumiInfo.seasons count] > 1 ? [_bangumiInfo.seasons count] + 1 : 0;
    }
    else if (section == 1) {
        return [_bangumiInfo.episodes count];
    }
    else if (section == 2) {
        return 1;
    }
    else {
        return 0;
    }
}

#pragma mark - Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [BangumiInfoHeaderView sizeForWidth:SSize.width];
    }
    else if (section == 1) {
        return [BangumiEpisodesHeaderView size];
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        CGFloat width = (collectionView.width - 5*10) / 4;
        return CGSizeMake(width, width * 0.4);
    }
    else if (indexPath.section == 2) {
        return [BangumiProfileCollectionViewCell sizeForWidth:collectionView.width bangumiInfo:_bangumiInfo];
    }
    return CGSizeZero;
}

#pragma mark - Cell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:BangumiInfoHeaderView.Identifier forIndexPath:indexPath];
        }
        else {
            
        }
    }
    else if (indexPath.section == 1) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:BangumiEpisodesHeaderView.Identifier forIndexPath:indexPath];
    }
    return NULL;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:BangumiEpisodeCollectionViewCell.Identifier forIndexPath:indexPath];
    }
    else if (indexPath.section == 2) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:BangumiProfileCollectionViewCell.Identifier forIndexPath:indexPath];
    }
    return NULL;
}

#pragma mark - Data
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [((BangumiInfoHeaderView *)view) setBangumiInfo:_bangumiInfo];
        }
    }
    else if (indexPath.section == 1) {
        [((BangumiEpisodesHeaderView *)view) setBangumiInfo:_bangumiInfo];
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [((BangumiEpisodeCollectionViewCell *)cell) setBangumiEpisode:_bangumiInfo.episodes[indexPath.row]];
    }
    else if (indexPath.section == 2) {
        [((BangumiProfileCollectionViewCell *)cell) setBangumiInfo:_bangumiInfo];
    }
}

@end


