//
//  VideoRankCollectionView.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoRankCollectionView.h"

#import "RankingVideoCell.h"
#import "UIView+CornerRadius.h"


@interface VideoRankCollectionView()<UICollectionViewDataSource>

@end

@implementation VideoRankCollectionView{

}

-(instancetype)initWithTitle:(NSString*)title{
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SSize.width, 70);
    layout.minimumLineSpacing = 1.0;
    layout.footerReferenceSize= CGSizeZero;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    
    if (self) {
        _model = [[VideoRankModel alloc] init];
        _title = title;
       [self registerClass:[RankingVideoCell class] forCellWithReuseIdentifier:NSStringFromClass([RankingVideoCell class])];
        self.dataSource = self;
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorRGB(243, 243, 243);
        self.backgroundView = view;
        [_model getvideoRankingWithTitle:title success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
            });
        } failure:^(NSString *errorMsg) {
            NSLog(@"%@",errorMsg);
        }];
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
    return _model.videoRanking.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RankingVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RankingVideoCell" forIndexPath:indexPath];
    cell.entity = _model.videoRanking[indexPath.row];
    return cell;
}

@end
