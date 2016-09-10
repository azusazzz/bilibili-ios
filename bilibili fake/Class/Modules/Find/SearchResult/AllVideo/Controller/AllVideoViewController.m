//
//  AllVideoViewController.m
//  bilibili fake
//
//  Created by C on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoViewController.h"

#import "Macro.h"

#import "AllVideoModel.h"
#import "SelectionView.h"
#import "AllVideoTableView.h"

#import "ArchiveSummaryCell.h"
#import "SeasonSummaryCell.h"

@interface AllVideoViewController()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation AllVideoViewController{
    SelectionView* selectionView;
    UICollectionView* videoCollectionView;
    UIView* ChoiceView;
    NSMutableArray<UIButton *>* button;
    
    AllVideoModel* model;
}
-(instancetype)initWithKeyword:(NSString *)keyword{
    if (self = [super init]) {
        model = [[AllVideoModel alloc] init];
        model.keyword = keyword;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ChoiceView.frame = CGRectZero;
}
-(void)viewDidLoad{
    [self loadSubViews];
    [self loadActions];
    [model getSearchResultWithSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [videoCollectionView reloadData];
        });
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
}

-(void)loadActions{
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)return model.seasonArr.count;
    if (section == 1) return  model.movieArr.count;
    return model.archiveArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SeasonSummaryCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SeasonSummaryCell" forIndexPath:indexPath];
        cell.entity = model.seasonArr[indexPath.row];
        return cell;
    }else if (indexPath.section == 2) {
        ArchiveSummaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArchiveSummaryCell" forIndexPath:indexPath];
        cell.entity = model.archiveArr[indexPath.row];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    
    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        if (indexPath.section == 0) {
            if (model.seasonCount<=3) return nil;
        } else if(indexPath.section == 1){
            if (model.movieCount<=3) return nil;
        }else if (indexPath.section == 2) {
            return nil;
        }
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        return footerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (CGSize){SSize.width,[SeasonSummaryCell height]};
    }else if (indexPath.section == 2) {
        return (CGSize){SSize.width,[ArchiveSummaryCell height]};
    }
    return (CGSize){SSize.width,70};
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (model.seasonCount<=3) return CGSizeZero;
    } else if(section == 1){
        if (model.movieCount<=3) return CGSizeZero;
        
    }else if (section == 2) {
        return CGSizeZero;
    }
    return (CGSize){SSize.width,42};
}
#pragma loadSubViews
-(void)loadSubViews{

    
    videoCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SSize.width, 70);
        layout.minimumLineSpacing = 0;
//        layout.headerReferenceSize = CGSizeZero;
//        layout.footerReferenceSize = CGSizeMake(SSize.width, 40);
        
        UICollectionView* view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = ColorRGBA(243, 243, 243, 0);
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [view registerClass:[ArchiveSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([ArchiveSummaryCell class])];
        [view registerClass:[SeasonSummaryCell class] forCellWithReuseIdentifier:NSStringFromClass([SeasonSummaryCell class])];
        [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
        [self.view addSubview:view];
        view;
    });
    
    selectionView = ({
        SelectionView* view = [[SelectionView alloc] init];
        [self.view addSubview:view];
        view;
    });
    //layout
    [videoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
    
    [selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(selectionView.backgroundView.mas_bottom);
    }];
}
@end
