//
//  VideoIntroView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroView.h"
#import <ReactiveCocoa.h>



#import "VideoIntroRelateCollectionViewCell.h"



#import "VideoIntroCollectionViewCell.h"
#import "VideoIntroStatCollectionViewCell.h"
#import "VideoIntroPagesCollectionViewCell.h"
#import "VideoIntroOwnerCollectionViewCell.h"
#import "VideoIntroTagsCollectionViewCell.h"


@interface VideoIntroView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    BOOL _showAllDesc;
}

@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation VideoIntroView

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundColor = ColorWhite(247);
        
        [self registerClass:[VideoIntroCollectionViewCell class] forCellWithReuseIdentifier:@"VideoIntro"];
        [self registerClass:[VideoIntroStatCollectionViewCell class] forCellWithReuseIdentifier:@"Stat"];
        [self registerClass:[VideoIntroPagesCollectionViewCell class] forCellWithReuseIdentifier:@"Pages"];
        [self registerClass:[VideoIntroOwnerCollectionViewCell class] forCellWithReuseIdentifier:@"Owner"];
        [self registerClass:[VideoIntroTagsCollectionViewCell class] forCellWithReuseIdentifier:@"Tags"];
        
        
        [self registerClass:[VideoIntroRelateCollectionViewCell class] forCellWithReuseIdentifier:@"relates"];
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        
    }
    return self;
}

- (void)setVideoInfo:(VideoInfoEntity *)videoInfo {
    _videoInfo = videoInfo;
    [self reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollViewDelegate scrollViewDidScroll:scrollView];
}

#pragma mark - UICollectionViewDataSource

#pragma mark - Number

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    else {
        return [_videoInfo.relates count];
    }
}

#pragma mark - Size

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return CGSizeMake(SSize.width, [VideoIntroCollectionViewCell heightForWidth:SSize.width videoInfo:_videoInfo showAllDesc:_showAllDesc]);
        }
        else if (indexPath.row == 1) {
            return CGSizeMake(SSize.width, [VideoIntroStatCollectionViewCell height]);
        }
        else if (indexPath.row == 2) {
            return CGSizeMake(SSize.width, [VideoIntroPagesCollectionViewCell heightWithPages:_videoInfo.pages]);
        }
        else if (indexPath.row == 3) {
            return CGSizeMake(SSize.width, [VideoIntroOwnerCollectionViewCell height]);
        }
        else if (indexPath.row == 4) {
            return CGSizeMake(SSize.width, [VideoIntroTagsCollectionViewCell heightForWidth:SSize.width tags:_videoInfo.tags]);
        }
    }
    return CGSizeMake(SSize.width, 100 + 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark - Cell


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoIntro" forIndexPath:indexPath];
        }
        else if (indexPath.row == 1) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"Stat" forIndexPath:indexPath];
        }
        else if (indexPath.row == 2) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"Pages" forIndexPath:indexPath];
        }
        else if (indexPath.row == 3) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"Owner" forIndexPath:indexPath];
        }
        else if (indexPath.row == 4) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"Tags" forIndexPath:indexPath];
        }
    }
    else if (indexPath.section == 1) {
       return [collectionView dequeueReusableCellWithReuseIdentifier:@"relates" forIndexPath:indexPath];
    }
    return NULL;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(VideoIntroRelateCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [((VideoIntroCollectionViewCell *)cell) setVideoInfo:_videoInfo showAllDesc:_showAllDesc];
        }
        else if (indexPath.row == 1) {
            ((VideoIntroStatCollectionViewCell *)cell).onClickDownload = _onClickDownload;
        }
        else if (indexPath.row == 2) {
            [((VideoIntroPagesCollectionViewCell *)cell) setPages:_videoInfo.pages];
            ((VideoIntroPagesCollectionViewCell *)cell).onClickPageItem = _onClickPageItem;
        }
        else if (indexPath.row == 3) {
            [((VideoIntroOwnerCollectionViewCell *)cell) setOwnerInfo:_videoInfo.owner pubdate:_videoInfo.pubdate];
        }
        else if (indexPath.row == 4) {
            [((VideoIntroTagsCollectionViewCell *)cell) setTags:_videoInfo.tags];
            ((VideoIntroTagsCollectionViewCell *)cell).onClickTag = _onClickTag;
        }
    }
    else {
        [cell setupVideoInfo:_videoInfo.relates[indexPath.row]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _showAllDesc = !_showAllDesc;
            [self reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        }
        return;
    }
    _onClickRelate ? _onClickRelate(indexPath.row) : NULL;
}


@end
