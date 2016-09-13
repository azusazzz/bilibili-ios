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
@interface UserInfoViewController()<UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation UserInfoViewController{
    UICollectionView* userInfoCollectionView;
}

-(instancetype)initWithUid:(NSInteger)uid{
    if (self = [super init]) {
        
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadSubviews];
    [self loadActions];

}

-(void)loadActions{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
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



#pragma loadSubviews

-(void)loadSubviews{
    userInfoCollectionView = ({
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        UICollectionView* col =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = ColorRGBA(243, 243, 243, 0);
        //col.layer.cornerRadius = 5.0;
        
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorRGB(243, 243, 243);
        col.backgroundView = view;
        col.showsVerticalScrollIndicator = NO;
        [col registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:col];
        col;
    });
    
    
    //layout
    [userInfoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
}




@end
