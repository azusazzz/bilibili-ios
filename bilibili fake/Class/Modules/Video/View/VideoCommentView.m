//
//  VideoCommentView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCommentView.h"
#import "VideoCommentCollectionViewCell.h"
#import "NSString+Size.h"

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
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreComment"];
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
    if (_commentList && commentList.count == 2) {
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:commentList[1].count - _commentList[1].count];
        for (NSInteger i=_commentList[1].count; i<commentList[1].count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:1]];
        }
        _commentList = [commentList copy];
        [self insertItemsAtIndexPaths:indexPaths];
    }
    else {
        _commentList = [commentList copy];
        [self reloadData];
    }
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
    
    [cell layoutIfNeeded];
    
    if (indexPath.section == 0) {
        [cell setupCommentInfo:_commentList[indexPath.section][indexPath.row] showReply:NO];
    }
    else {
        [cell setupCommentInfo:_commentList[indexPath.section][indexPath.row] showReply:YES];
    }
    
    cell.topLine.hidden = indexPath.row == 0;
    if (_hasNext && indexPath.section == _commentList.count-1 && indexPath.row == _commentList[_commentList.count-1].count-1) {
        _hasNext = NO;
        _loadNextPage ? _loadNextPage() : NULL;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [VideoCommentCollectionViewCell sizeForComment:_commentList[indexPath.section][indexPath.row] showReply:NO];
    }
    else {
        return [VideoCommentCollectionViewCell sizeForComment:_commentList[indexPath.section][indexPath.row] showReply:YES];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(SSize.width, 20);
    }
    return CGSizeMake(SSize.width, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1) {
        return NULL;
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MoreComment" forIndexPath:indexPath];
    
    
    if (view.tag == 0) {
        view.backgroundColor = ColorWhite(247);
        view.tag = 1;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorWhite(200);
        [view addSubview:lineView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"更多热门评论>>" forState:UIControlStateNormal];
        [button setTitleColor:CRed forState:UIControlStateNormal];
        button.titleLabel.font = Font(13);
        button.backgroundColor = ColorWhite(247);
        [view addSubview:button];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.centerY.equalTo(view);
            make.height.offset = 0.5;
        }];
        CGFloat buttonWidth = [button.titleLabel.text widthWithFont:Font(13) maxHeight:15] + 10;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = buttonWidth;
            make.height.offset = 15;
            make.center.equalTo(view);
        }];
    }
    
    return view;
}


@end
