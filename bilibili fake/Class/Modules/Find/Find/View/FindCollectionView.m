//
//  FindTabelView.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindCollectionView.h"
#import "FindCell.h"
#import "UIView+CornerRadius.h"
#import "Macro.h"
@implementation FindCollectionView{
    NSArray<NSArray *>* dataArr;
}
-(instancetype)init{
    
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SSize.width, SSize.width*0.5 + 50 + 10);
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(SSize.width, 50);
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeMake(SSize.width, 10);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.dataSource =self;
        self.backgroundColor = [UIColor clearColor];
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorWhite(255);
        self.backgroundView = view;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[FindCell class] forCellWithReuseIdentifier:NSStringFromClass([FindCell class])];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        dataArr = @[@[@{@"title":@"兴趣圈",@"icon":@"discovery_circle_ico"},@{@"title":@"话题中心",@"icon":@"discovery_topicCenter"},@{@"title":@"活动中心",@"icon":@"home_recommend_activity"}],
                    @[@{@"title":@"原创排行榜",@"icon":@"discovery_rankOriginal_ico"},@{@"title":@"全区排行榜",@"icon":@"discovery_rankAll_ico"}],
                    @[@{@"title":@"游戏中心",@"icon":@"discovery_game_ico"}]];
    
    }
    return self;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArr[section].count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindCell class]) forIndexPath:indexPath];
    NSDictionary* dic = dataArr[indexPath.section][indexPath.row];
    [cell setIconImage:[UIImage imageNamed:[dic objectForKey:@"icon"]] TitleText:[dic objectForKey:@"title"] line:indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
     UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        footerView.backgroundColor = ColorWhite(230);
        return footerView;
    }
    return nil;
}

@end
