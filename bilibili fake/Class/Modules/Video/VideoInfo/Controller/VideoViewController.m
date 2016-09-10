//
//  VideoViewController.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoViewController.h"


#import "VideoHeaderView.h"
#import "VideoIntroView.h"
#import "VideoCommentView.h"
#import "VideoTabBar.h"

#import "MediaPlayer.h"

#import "DownloadVideoSelectView.h"

#import "UIViewController+GetViewController.h"

#import "SearchResultViewController.h" // 点击标签 搜索

@interface VideoViewController ()
<UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    VideoTabBar *_tabBar;
}

@property (strong, nonatomic) UIScrollView *backgroundScrollView;

@property (strong, nonatomic) VideoHeaderView *headerView;

@property (strong, nonatomic) VideoIntroView *introView;

@property (strong, nonatomic) VideoCommentView *commentView;

@property (assign, nonatomic) NSInteger aid;

@property (strong, nonatomic) VideoModel *model;

@property (strong, nonatomic) VideoPageInfoEntity *currentPage;


@end

@implementation VideoViewController


#pragma mark - URLRouterProtocol

// http://www.bilibili.com/video/av2344701/
// bilibili://video/6002357
// http://www.bilibili.com/mobile/video/av5104768.html

+ (NSInteger)getAidForURL:(NSString *)URL {
    NSInteger aid = 0;
    NSRange range = [URL rangeOfString:@"/video/av"];
    if (range.length > 0) {
        URL = [URL stringByReplacingOccurrencesOfString:@".html" withString:@""];
        aid = [[[URL substringFromIndex:range.location + range.length] componentsSeparatedByString:@"/"][0] integerValue];
    }
    else {
        range = [URL rangeOfString:@"bilibili://video/"];
        if (range.length > 0) {
            aid = [[URL lastPathComponent] integerValue];
        }
    }
    return aid;
}

+ (BOOL)canOpenURL:(NSString *)URL {
    return [self getAidForURL:URL] > 0;
}

+ (BOOL)openURLWithRouterParameters:(URLRouterParameters *)parameters {
    NSInteger aid = [self getAidForURL:parameters.URL];
    if (aid <= 0) {
        return NO;
    }
    
    VideoViewController *controller = [[VideoViewController alloc] initWithAid:aid];
    [[UIViewController currentNavigationViewController] pushViewController:controller animated:YES];
    return YES;
}

#pragma mark - Init

- (instancetype)initWithAid:(NSInteger)aid {
    if (self = [super init]) {
        _aid = aid;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWhite(240);
    
    [self initSubviews];
    
    [self loadData];
    
    
    __weak typeof(self) weakself = self;
    
    /**
     *  点击头部  播放视频
     */
    [_headerView setOnClickPlay:^{
        [weakself playVideo];
    }];
    
    
    [_introView setOnClickDownload:^{
        
        [DownloadVideoSelectView showWithVideoInfo:weakself.model.videoInfo];
        
    }];
    
    
    /**
     *  点击简介-分集   切换当前分集 并播放
     *
     */
    [_introView setOnClickPageItem:^(NSInteger idx) {
        weakself.currentPage = weakself.model.videoInfo.pages[idx];
        [weakself playVideo];
    }];
    
    /**
     *  点击简介-标签
     *
     */
    [_introView setOnClickTag:^(NSString *tag) {
        if ([tag length] <= 0) {
            return;
        }
        SearchResultViewController *searchController = [[SearchResultViewController alloc] initWithKeyword:tag];
        [weakself.navigationController pushViewController:searchController animated:YES];
    }];
    
    /**
     *  点击简介-视频相关
     *
     */
    [_introView setOnClickRelate:^(NSInteger idx) {
        weakself.aid = weakself.model.videoInfo.relates[idx].aid;
        [weakself loadData];
        [weakself.introView setContentOffset:CGPointZero animated:YES];
    }];
    
    /**
     *  评论-加载下一页数据
     */
    [_commentView setHandleLoadNextPage:^{
        [weakself.model getVideoCommentWithSuccess:^{
            //
            weakself.commentView.hasNext = weakself.model.comment.hasNext;
            weakself.commentView.commentList = weakself.model.comment.commentList;
        } failure:^(NSString *errorMsg) {
            //
            HUDFailure(@"网络请求出错");
        }];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Event

/**
 *  播放视频
 */
- (void)playVideo {
    if (!self.model.videoInfo) {
        return;
    }
    
    __weak typeof(self) weakself = self;
    HUDLoading(@"正在解析视频地址");
    [self.model getVideoURLWithCid:self.currentPage.cid completionBlock:^(NSURL *videoURL) {
        HUDLoadingHidden();
        if (videoURL) {
            [MediaPlayer playerWithURL:videoURL cid:weakself.currentPage.cid title:weakself.currentPage.part inViewController:weakself];
        }
        else {
            HUDFailure(@"获取视频地址失败");
        }
    }];
}


- (void)loadData {
    if (!_aid) {
        HUDFailure(@"aid错误");
        return;
    }
    if (!_model) {
        _model = [[VideoModel alloc] init];
    }
    _model.aid = _aid;
    
    
    [_model getVideoInfoWithSuccess:^{
        //
        if (_model.videoInfo.pages.count) {
            _currentPage = _model.videoInfo.pages[0];
        }
        else {
            HUDFailure(@"视频信息不存在");
            return;
        }
        [_headerView setupVideoInfo:_model.videoInfo];
        _introView.videoInfo = _model.videoInfo;
        [_tabBar setTitle:[NSString stringWithFormat:@"评论(%ld)", _model.videoInfo.stat.reply] forIndex:1];
    } failure:^(NSString *errorMsg) {
        //
        HUDFailure(@"视频信息-网络请求出错");
    }];
    
    
    [_model getVideoCommentWithSuccess:^{
        //
        _commentView.hasNext = _model.comment.hasNext;
        _commentView.commentList = _model.comment.commentList;
    } failure:^(NSString *errorMsg) {
        //
        HUDFailure(@"评论-网络请求出错");
    }];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _backgroundScrollView) {
        _tabBar.contentOffset = scrollView.contentOffset.x / scrollView.width;
    }
    else {
        CGFloat offset = scrollView.contentOffset.y / 2;
        if (offset < 0) {
            offset = 0;
        }
        if (_headerView.height - offset < 20+44) {
            offset = _headerView.height - 20-44;
        }
        
        if (-offset != _headerView.transform.ty) {
            _headerView.transform = CGAffineTransformMakeTranslation(0, -offset/2);
        }
        
        if (_headerView.backgroundView.image) {
            CGFloat blurRadius = offset / (_headerView.height);
            [_headerView.backgroundView blur:blurRadius * 3];
        }
        
        
        [_tabBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_bottom).offset = -offset;
        }];
        
    }
}

#pragma mark - UIGestureRecognizerDelegate


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:_backgroundScrollView];
    if (gestureRecognizer.view == _headerView) {
        return translation.x > 0;
    }
    else if (gestureRecognizer.view == _backgroundScrollView) {
        return _backgroundScrollView.contentOffset.x == 0 && translation.x > 0;
    }
    else {
        return NO;
    }
}


- (void)initSubviews {
    _headerView = [[VideoHeaderView alloc] init];
    [self.view addSubview:_headerView];
    
    _tabBar = [[VideoTabBar alloc] initWithTitles:@[@"简介", @"评论"]];
    
    __weak typeof(self) weakself = self;
    [_tabBar setOnClickItem:^(NSInteger idx) {
        [weakself.backgroundScrollView setContentOffset:CGPointMake(weakself.backgroundScrollView.width * idx, 0) animated:YES];
    }];
    [self.view addSubview:_tabBar];
    
    _backgroundScrollView = [[UIScrollView alloc] init];
    _backgroundScrollView.bounces = NO;
    _backgroundScrollView.pagingEnabled = YES;
    _backgroundScrollView.delegate = self;
    [self.view addSubview:_backgroundScrollView];
    
    _introView = [[VideoIntroView alloc] init];
    _introView.scrollViewDelegate = self;
    [_backgroundScrollView addSubview:_introView];
    
    _commentView = [[VideoCommentView alloc] init];
    _commentView.scrollViewDelegate = self;
    [_backgroundScrollView addSubview:_commentView];
    
    
    
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.offset = 0;
        make.height.equalTo(_headerView.mas_width).multipliedBy(450.0/720.0);
    }];
    [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(_headerView.mas_bottom);
        make.height.offset = 40;
    }];
    [_backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.top.equalTo(_tabBar.mas_bottom);
        make.bottom.offset = 0;
    }];
    [_introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.offset = 0;
        make.width.equalTo(_backgroundScrollView);
        make.height.equalTo(_backgroundScrollView);
    }];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_introView.mas_right);
        make.top.offset = 0;
        make.width.equalTo(_backgroundScrollView);
        make.height.equalTo(_backgroundScrollView);
    }];
    [_backgroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_commentView);
    }];
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    NSArray *internalTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:internalTarget action:internalAction];
    panGesture.delegate = self;
    [_backgroundScrollView addGestureRecognizer:panGesture];
    UIPanGestureRecognizer *headerPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:internalTarget action:internalAction];
    headerPanGesture.delegate = self;
    [_headerView addGestureRecognizer:headerPanGesture];
}


@end
