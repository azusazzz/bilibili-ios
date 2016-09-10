//
//  AllVideoTableView.m
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoTableView.h"
@interface AllVideoTableView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation AllVideoTableView
-(instancetype)init{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SSize.width, 70);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeMake(SSize.width, 40);
    
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {

        //        layout.sectionInset =  UIEdgeInsetsMake(20, 0, 20, 0);
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = ColorRGBA(243, 243, 243, 0);
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
    }
    return self;
}






- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
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





//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    if (cell == NULL) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
//    }
//    cell.backgroundColor = [UIColor yellowColor];
//    return cell;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    UITableView *tableview = (UITableView *)scrollView;
//    CGFloat sectionHeaderHeight = 0;
//    CGFloat sectionFooterHeight = 100;
//    CGFloat offsetY = tableview.contentOffset.y;
//    
//    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
//    {
//        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//        
//    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
//    {
//        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//        
//    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)         {
//        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
//        
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return section==2?0:100;
//}
//
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView* view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor greenColor];
//    return view;
//}
@end
