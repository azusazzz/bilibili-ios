//
//  UserInfoSubmitVideosView.m
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoCollectionView.h"
#import "SubmitVideoCell.h"
#import "UserInfoHeaderReusableView.h"

@implementation UserInfoCollectionView
-(instancetype)init{
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [SubmitVideoCell size];
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(SSize.width-20, 20);
    layout.footerReferenceSize = CGSizeZero;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
   
    if ( self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        self.dataSource =self;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[SubmitVideoCell class] forCellWithReuseIdentifier:NSStringFromClass([SubmitVideoCell class])];
        [self registerClass:[UserInfoHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UserInfoHeaderReusableView class])];
    }
    return self;
}

-(void)setEntity:(UserInfoSubmitVideosEntity *)entity{
    _entity = entity;
    [self reloadData];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_entity.vlist.count) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ceil(_entity.vlist.count/2.0)*([SubmitVideoCell size].height+10)+20));
        }];
    }
    return _entity.vlist.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubmitVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SubmitVideoCell class]) forIndexPath:indexPath];
    //cell.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
    cell.entity = _entity.vlist[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UserInfoHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UserInfoHeaderReusableView" forIndexPath:indexPath];
        //footerView.backgroundColor = ColorWhite(230);
        switch (indexPath.section) {
            case 0:
                [headerView setTitle:@"全部投稿" Count:_entity.count];
                break;
                
            default:
                break;
        }
        return headerView;
    }
    return nil;
}
@end
