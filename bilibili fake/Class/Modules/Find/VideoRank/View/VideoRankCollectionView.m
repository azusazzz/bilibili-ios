//
//  VideoRankCollectionView.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRankCollectionView.h"

@interface VideoRankCollectionView()<UICollectionViewDataSource>

@end

@implementation VideoRankCollectionView

-(instancetype)initWithTitle:(NSString*)title{
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SSize.width, 70);
    layout.minimumLineSpacing = 1.0;
    layout.footerReferenceSize= CGSizeZero;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    
    if (self) {
        _title = title;
       [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        self.dataSource = self;
    }
    return  self;
}
#pragma UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


@end
