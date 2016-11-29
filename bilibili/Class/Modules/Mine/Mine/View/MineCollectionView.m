//
//  MineCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MineCollectionView.h"
#import "MineCollectionViewCell.h"
#import "MineHeaderCollectionReusableView.h"
#import <ReactiveCocoa.h>

@interface MineCollectionView ()
<UICollectionViewDelegate, UICollectionViewDataSource>
{
    
}
@end

@implementation MineCollectionView


- (void)setGroups:(NSArray<MineGroupEntity *> *)groups {
    _groups = groups;
    [self reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.backgroundView.y < 0) {
        self.backgroundView.y = 0;
    }
}

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(SSize.width, 40);
    flowLayout.footerReferenceSize = CGSizeMake(SSize.width, 10);
    flowLayout.itemSize = CGSizeMake((SSize.width-1*5) / 4, (SSize.width-1*5) / 4);
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = ColorWhite(247);
        self.backgroundView.layer.cornerRadius = 6;
        self.backgroundView.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.backgroundColor = CRed;
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES;
        [self registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[MineHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    }
    return self;
}

/**
 *  Number
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.groups count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = [self.groups[section].items count];
    return count % 4 == 0 ? count : count + (4-count%4);
}
/**
 *  Cell
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
    }
    return NULL;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
}
/**
 *  Data
 */
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ((MineHeaderCollectionReusableView *)view).title = _groups[indexPath.section].title;
        [collectionView.backgroundView addSubview:view];
        
        if (view.tag == 0) {
            view.tag = 1;
            [RACObserve(collectionView, contentOffset) subscribeNext:^(id x) {
                CGFloat y = [x CGPointValue].y;
                view.transform = CGAffineTransformMakeTranslation(0, -(y>0 ? y : 0));
            }];
        }
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(MineCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _groups[indexPath.section].items.count) {
        [cell setItem:self.groups[indexPath.section].items[indexPath.row]];
    }
    else {
        [cell setItem:NULL];
    }
}

/**
 *  Select
 */
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row < _groups[indexPath.section].items.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _handleDidSelectedItem ? _handleDidSelectedItem(indexPath) : NULL;
}

@end
