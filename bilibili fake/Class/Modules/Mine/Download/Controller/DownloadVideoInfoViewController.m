//
//  DownloadVideoInfoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoInfoViewController.h"
#import "DownloadVideoInfoHeaderView.h"
#import "DownloadVideoPageCollectionViewCell.h"

#import "VideoViewController.h" // 视频信息
#import "MediaPlayer.h" // 视频播放

// Tool
#import "UIViewController+PopGesture.h"
#import "UIViewController+HeaderView.h"


@interface DownloadVideoInfoViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>
{
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


- (void)edit {
    
}

#pragma mark - Number 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_video.pages count];
}

#pragma mark - Size

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.width, [DownloadVideoInfoHeaderView height]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 0, 15, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, [DownloadVideoPageCollectionViewCell height]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

#pragma mark - Cell 

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    }
    return NULL;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Page" forIndexPath:indexPath];
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        __weak typeof(self) weakself = self;
        ((DownloadVideoInfoHeaderView *)view).titleLabel.text = self.video.title;
        [((DownloadVideoInfoHeaderView *)view) setHandleTap:^{
            // Tap Header
            NSInteger aid = weakself.video.aid;
            [weakself.navigationController pushViewController:[[VideoViewController alloc] initWithAid:aid] animated:YES];
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(DownloadVideoPageCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setVideoPage:_video.pages[indexPath.row]];
}

#pragma mark - Selected

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_video.pages[indexPath.row].fileName length] > 0) {
        NSURL *videoURL = [NSURL fileURLWithPath:_video.pages[indexPath.row].filePath];
        [MediaPlayer playerWithURL:videoURL cid:_video.pages[indexPath.row].cid title:_video.pages[indexPath.row].part inViewController:self];
    }
    else {
        if (_video.pages[indexPath.row].operation.status == DownloadOperationStatusRuning) {
            [_video.pages[indexPath.row].operation pause];
        }
        else {
            [_video.pages[indexPath.row].operation resume];
        }
    }
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_collectionView];
    if (fabs(translation.x) <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}


#pragma mark - View

- (void)loadSubviews {
    self.view.backgroundColor = CRed;
    
    UIBarButtonItem *deleteBarButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = deleteBarButton;
    
    [self navigationBar];
    
    _collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = ColorWhite(247);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.alwaysBounceVertical = YES;
        [collectionView registerClass:[DownloadVideoInfoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [collectionView registerClass:[DownloadVideoPageCollectionViewCell class] forCellWithReuseIdentifier:@"Page"];
        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.equalTo(self.navigationBar.mas_bottom);
            make.bottom.offset = 0;
        }];
        collectionView;
    });
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [_collectionView addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
}


@end
