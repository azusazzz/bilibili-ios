//
//  UserInfoViewController.m
//  bilibili fake
//
//  Created by C on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoViewController.h"

#import "Macro.h"
#import <Masonry.h>
#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"
#import "UIView+Frame.h"


#import "UserInfoHeaderReusableView.h"
#import "UserInfoModel.h"

@interface UserInfoViewController()<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation UserInfoViewController{
    UIImageView* backgroundImageView;
    UICollectionView* userInfoCollectionView;
    UserInfoModel * model;
}

-(instancetype)initWithMid:(NSInteger)mid{
    if (self = [super init]) {
        self.title = @"用户名字";
        model = [[UserInfoModel alloc] initWithMid:mid];
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadSubviews];
    [self loadActions];
    [self loadData];
    [self.navigationBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 0;
        make.height.offset = 64;
    }];
    [self navigationBar].alpha = 0;;
}

-(void)loadActions{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
}
-(void)loadData{
    [model getCardEntityWithSuccess:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           [userInfoCollectionView reloadData];
        }];
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];

}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}

#pragma UICollectionViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    [backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.view);
        make.height.mas_equalTo(120-scrollView.contentOffset.y>SSize.width*0.57?120-scrollView.contentOffset.y:SSize.width*0.57);
        make.width.equalTo(backgroundImageView.mas_height).multipliedBy(1.75);
    }];
    self.navigationBar.alpha = scrollView.contentOffset.y/64.0;
}
#pragma mark ---- UICollectionViewDataSource

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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if (indexPath.section == 0) {
            UserInfoHeaderReusableView* cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UserInfoHeaderReusableView" forIndexPath:indexPath];
            cell.entity = model.cardEntity;
            return cell;
        }
        

    }
    return nil;
}
//size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, 60);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return CGSizeMake(collectionView.width, [UserInfoHeaderReusableView height]);
            break;
            
        default:
            break;
    }
    return CGSizeZero;
}

#pragma loadSubviews

-(void)loadSubviews{
    self.view.backgroundColor = ColorWhite(243);
    
    backgroundImageView = ({
        UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space_header"]];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.backgroundColor = ColorWhite(0);
        [self.view addSubview:view];
        view;
    });
    

    userInfoCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        //layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
        
        UICollectionView* col =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = ColorWhiteAlpha(243, 0);
//        UIView* view = [[UIView alloc] init];
//        view.backgroundColor = ColorWhite(200);
//        col.backgroundView = view;
        //col.layer.cornerRadius = 5.0;
        
        col.showsVerticalScrollIndicator = NO;
        [col registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        [col registerClass:[UserInfoHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UserInfoHeaderReusableView class])];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:col];
        col;
    });
    
    
    //layout
    [userInfoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
  
    
    
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(backgroundImageView.mas_width).multipliedBy(0.57);
    }];

}




@end
