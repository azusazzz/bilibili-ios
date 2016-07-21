//
//  VideoCommentView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentView.h"
#import "VideoCommentCollectionViewCell.h"

@interface VideoCommentView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation VideoCommentView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundColor = ColorWhite(247);
        [self registerClass:[VideoCommentCollectionViewCell class] forCellWithReuseIdentifier:@"VideoComment"];
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollViewDelegate scrollViewDidScroll:scrollView];
}

- (void)setCommentList:(NSArray<NSArray<VideoCommentItemEntity *> *> *)commentList {
    _commentList = commentList;
    [self reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _commentList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _commentList[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoComment" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(VideoCommentCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setupCommentInfo:_commentList[indexPath.section][indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [VideoCommentCollectionViewCell sizeForComment:_commentList[indexPath.section][indexPath.row]];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SSize.width, 10);
}


@end
