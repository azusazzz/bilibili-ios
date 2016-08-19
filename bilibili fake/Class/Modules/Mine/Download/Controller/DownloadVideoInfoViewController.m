//
//  DownloadVideoInfoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoInfoViewController.h"
#import "UIViewController+HeaderView.h"
#import "DownloadVideoPageCollectionViewCell.h"

@interface DownloadVideoInfoViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    DownloadVideoEntity *_video;
    
    UICollectionView *_collectionView;
}
@end

@implementation DownloadVideoInfoViewController

- (instancetype)initWithDownloadVideo:(DownloadVideoEntity *)downloadVideo {
    self = [super init];
    if (!self) {
        return NULL;
    }
    
    _video = downloadVideo;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"av%ld", _video.aid];
    [self loadSubviews];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)loadSubviews {
    self.view.backgroundColor = CRed;
    
    [self navigationBar];
    
    
    _collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = ColorWhite(247);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[DownloadVideoPageCollectionViewCell class] forCellWithReuseIdentifier:@"Page"];
        [self.view addSubview:collectionView];
        collectionView;
    });
}

#pragma mark - Number 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_video.pages count];
}

#pragma mark - Size

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.width, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, [DownloadVideoPageCollectionViewCell height]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

#pragma mark - Cell 

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Page" forIndexPath:indexPath];
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(DownloadVideoPageCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
