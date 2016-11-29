//
//  VideoIntroPagesCollectionViewCell.m
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroPagesCollectionViewCell.h"
#import "VideoPageNameCollectionViewCell.h"

@interface VideoIntroPagesCollectionViewCell ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionViewFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
    UILabel *_titleLable;
    NSInteger _index;
    
    UIView *_bottomLine;
}
@end

@implementation VideoIntroPagesCollectionViewCell

+ (CGFloat)heightWithPages:(NSArray<VideoPageInfoEntity *> *)pages {
    if (pages.count > 1) {
        return 15+15 + 15+70+20 + 15;
    }
    else {
        return 0;
    }
}

- (void)setPages:(NSArray<VideoPageInfoEntity *> *)pages {
    _pages = pages;
    
    _bottomLine.hidden = pages.count <= 1;
    
    if (pages.count <= 1) {
        return;
    }
    
    [_collectionView reloadData];
    
    _titleLable.text = [NSString stringWithFormat:@"分集 (%ld)", _pages.count];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_titleLable.attributedText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:ColorWhite(86) range:NSMakeRange(0, 2)];
    _titleLable.attributedText = attributedString;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"分集";
        _titleLable.font = Font(13);
        _titleLable.textColor = ColorWhite(146);
        [self addSubview:_titleLable];
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = ColorWhite(247);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[VideoPageNameCollectionViewCell class] forCellWithReuseIdentifier:@"Page"];
        [self addSubview:_collectionView];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 15;
            make.width.offset = 100;
            make.height.offset = 15;
        }];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(_titleLable.mas_bottom).offset = 15;
            make.height.offset = 90;
        }];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = ColorWhite(200);
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.bottom.offset = 0;
            make.height.offset = 0.5;
        }];
        
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _pages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Page" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(VideoPageNameCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.title = _pages[indexPath.row].part;
    [cell selectItem:indexPath.row == _index];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 70);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _index = indexPath.row;
    [collectionView reloadData];
    
    _onClickPageItem ? _onClickPageItem(indexPath.row) : NULL;
    
}


@end
