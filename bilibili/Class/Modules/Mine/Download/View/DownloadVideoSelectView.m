//
//  DownloadVideoSelectView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoSelectView.h"
#import "UIViewController+GetViewController.h"
#import "DownloadVideoModel.h"
#import "DownloadVideoInfoViewController.h"

@interface DownloadVideoSelectView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *qualityButton;    // 画质
    UIButton *closeButton;  // 关闭
    UILabel *leftTitleLabel;    // 点击集数下载
    UILabel *surplusLabel;  // 剩余
    UICollectionView *pageCollectionView;   // 分集
    UIButton *downloadAllButton;    // 缓存全部
    UIButton *downloadManagerButton;    // 管理缓存
    
    VideoInfoEntity *_videoInfo;
}

@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation DownloadVideoSelectView

+ (instancetype)showWithVideoInfo:(VideoInfoEntity *)videoInfo {
    DownloadVideoSelectView *selectView = [[DownloadVideoSelectView alloc] initWithVideoInfo:videoInfo];
    [selectView show];
    return selectView;
}

- (instancetype)initWithVideoInfo:(VideoInfoEntity *)videoInfo {
    self = [super init];
    if (!self) {
        return NULL;
    }
    
    _videoInfo = videoInfo;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    
    qualityButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"画质: 高清" forState:UIControlStateNormal];
        [button setTitleColor:CRed forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:button];
        button;
    });
    
    closeButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button setTitleColor:CRed forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    });
    
    UIView *lineView1 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorWhite(230);
        [self addSubview:view];
        view;
    });
    
    leftTitleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = Font(14);
        label.textColor = ColorWhite(146);
        label.text = @"点击集数下载";
        [self addSubview:label];
        label;
    });
    
    surplusLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = Font(14);
        label.textColor = ColorWhite(146);
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
        NSDictionary *fileSysAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:path error:nil];
        NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
        label.text = [NSString stringWithFormat:@"剩余%.1lfGB", [freeSpace longLongValue]/1024.0/1024.0/1024.0];
        label;
    });
    
    pageCollectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self addSubview:collectionView];
        collectionView;
    });
    
    downloadAllButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"缓存全部" forState:UIControlStateNormal];
        [button setTitleColor:CRed forState:UIControlStateNormal];
        [button addTarget:self action:@selector(downloadAll) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    });
    
    UIView *lineView2 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorWhite(230);
        [self addSubview:view];
        view;
    });
    
    downloadManagerButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"管理缓存(1)" forState:UIControlStateNormal];
        [button setTitleColor:CRed forState:UIControlStateNormal];
        [button addTarget:self action:@selector(downloadManger) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    });
    
    _backgroundView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorWhiteAlpha(0, 0.4);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [view addGestureRecognizer:tapGesture];
        view;
    });
    
    
#pragma mark Layout
    
    [qualityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 80;
        make.height.offset = 40;
        make.top.offset = 0;
    }];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.right.offset = -10;
        make.width.offset = 40;
        make.height.offset = 40;
    }];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.top.equalTo(qualityButton.mas_bottom);
        make.height.offset = 0.5;
    }];
    [leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(lineView1.mas_bottom).offset = 15;
        make.width.offset = 120;
        make.height.offset = 15;
    }];
    [surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.top.equalTo(lineView1.mas_bottom).offset = 15;
        make.width.offset = 80;
        make.height.offset = 15;
    }];
    [pageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(leftTitleLabel.mas_bottom).offset = 15;
        make.bottom.equalTo(downloadAllButton.mas_top);
    }];
    [downloadAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.bottom.offset = 0;
        make.height.offset = 50;
        make.width.equalTo(self.mas_width).multipliedBy(0.49);
    }];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.width.offset = 0.5;
        make.top.equalTo(downloadAllButton).offset = 10;
        make.bottom.offset = -10;
    }];
    [downloadManagerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.height.offset = 50;
        make.width.equalTo(self.mas_width).multipliedBy(0.49);
    }];
    
    return self;
}

- (void)show {
    if (self.superview) {
        return;
    }
    self.backgroundView.frame = [UIScreen mainScreen].bounds;
    self.frame = CGRectMake(10, SSize.height*0.4-10, SSize.width-20, SSize.height*0.6);
    [[UIViewController currentViewController].view addSubview:self.backgroundView];
    [[UIViewController currentViewController].view addSubview:self];
    
}

- (void)hide {
    if (!self.superview) {
        return;
    }
    [self removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}

- (void)downloadAll {
    DownloadVideoEntity *video = [[DownloadVideoEntity alloc] init];
    video.aid = _videoInfo.aid;
    video.title = _videoInfo.title;
    video.pic = _videoInfo.pic;
    
    for (VideoPageInfoEntity *videoPageInfo in _videoInfo.pages) {
        if ([[DownloadVideoModel sharedInstance] hasVideoPageWithAid:_videoInfo.aid cid:videoPageInfo.cid]) {
            continue;
        }
        DownloadVideoPageEntity *page = [[DownloadVideoPageEntity alloc] init];
        page.cid = videoPageInfo.cid;
        page.part = videoPageInfo.part;
        page.page = videoPageInfo.page;
        [page.operation resume];
        [video.pages addObject:page];
    }
    
    if ([video.pages count] == 0) {
        return;
    }
    
    
    
    [[DownloadVideoModel sharedInstance] downloadVideo:video];
    [pageCollectionView reloadData];
}

- (void)downloadManger {
    DownloadVideoEntity *video;
    for (DownloadVideoEntity *obj in [DownloadVideoModel sharedInstance].list) {
        if (obj.aid == _videoInfo.aid) {
            video = obj;
            break;
        }
    }
    
    if (!video) {
        return;
    }
    
    for (UIViewController *controller in [UIViewController currentNavigationViewController].viewControllers) {
        if ([controller isKindOfClass:[DownloadVideoInfoViewController class]]) {
            DownloadVideoInfoViewController *downloadInfoController = (DownloadVideoInfoViewController *)controller;
            if (downloadInfoController.video.aid == video.aid) {
                [[UIViewController currentNavigationViewController] popToViewController:controller animated:YES];
                return;
            }
        }
    }
    
    [[UIViewController currentNavigationViewController] pushViewController:[[DownloadVideoInfoViewController alloc] initWithDownloadVideo:video] animated:YES];
}

#pragma mark - Number

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_videoInfo.pages count];
}

#pragma mark - Size

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width-20, 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

#pragma mark - Cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
}

#pragma mark - Data

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UILabel *titleLable = [cell.contentView viewWithTag:784658];
    UIImageView *statusImageView = [cell.contentView viewWithTag:5647987];
    if (![titleLable isKindOfClass:[UILabel class]]) {
        titleLable = [[UILabel alloc] init];
        titleLable.font = Font(14);
        titleLable.textColor = ColorWhite(146);
        titleLable.tag = 784658;
        [cell.contentView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.offset = 0;
            make.bottom.offset = 0;
        }];
        
        statusImageView = [[UIImageView  alloc] init];
        statusImageView.tag = 5647987;
        [cell.contentView addSubview:statusImageView];
        [statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@16);
            make.height.equalTo(@16);
            make.centerY.offset = 0;
            make.right.offset = -10;
        }];
        
        cell.contentView.layer.cornerRadius = 6;
        cell.contentView.layer.borderColor = ColorWhite(200).CGColor;
        cell.contentView.layer.borderWidth = 0.5;
    }
    
    VideoPageInfoEntity *pageInfo = _videoInfo.pages[indexPath.row];
    titleLable.text = pageInfo.part;
    
    DownloadVideoPageEntity *page;
    
    if (page = [[DownloadVideoModel sharedInstance] hasVideoPageWithAid:_videoInfo.aid cid:pageInfo.cid], page) {
        if ([page.fileName length] > 0) {
            statusImageView.image = [UIImage imageNamed:@"season_downloaded"];
        }
        else {
            statusImageView.image = [UIImage imageNamed:@"season_downloading"];
        }
    }
    else {
        statusImageView.image = NULL;
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoPageInfoEntity *videoPageInfo = _videoInfo.pages[indexPath.row];
    
    if ([[DownloadVideoModel sharedInstance] hasVideoPageWithAid:_videoInfo.aid cid:videoPageInfo.cid]) {
        HUDFailureInView(@"已添加", self);
        return;
    }
    
    DownloadVideoEntity *video = [[DownloadVideoEntity alloc] init];
    video.aid = _videoInfo.aid;
    video.title = _videoInfo.title;
    video.pic = _videoInfo.pic;
    DownloadVideoPageEntity *page = [[DownloadVideoPageEntity alloc] init];
    page.aid = _videoInfo.aid;
    page.cid = videoPageInfo.cid;
    page.part = videoPageInfo.part;
    page.page = videoPageInfo.page;
    page.fileName = @"";
    [video.pages addObject:page];
    
    [[DownloadVideoModel sharedInstance] downloadVideo:video];
    
    [page.operation resume];
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

@end





