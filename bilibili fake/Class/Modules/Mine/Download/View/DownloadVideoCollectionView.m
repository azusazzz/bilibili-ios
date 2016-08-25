//
//  DownloadVideoCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoCollectionView.h"
#import "DownloadVideoCollectionViewCell.h"


@interface DownloadVideoCollectionView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    
}
@end

@implementation DownloadVideoCollectionView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundColor = ColorWhite(247);
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES;
        [self registerClass:[DownloadVideoCollectionViewCell class] forCellWithReuseIdentifier:@"DownloadVideo"];
    }
    return self;
}

- (void)setList:(NSArray<DownloadVideoEntity *> *)list {
    _list = list;
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !_selectedVideo ?: _selectedVideo(_list[indexPath.row]);
}

#pragma mark - Number

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_list count];
}

#pragma mark - Size

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 20, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

#pragma mark - Cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"DownloadVideo" forIndexPath:indexPath];
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(DownloadVideoCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setDownloadVideoEntity:_list[indexPath.row]];
}


@end


