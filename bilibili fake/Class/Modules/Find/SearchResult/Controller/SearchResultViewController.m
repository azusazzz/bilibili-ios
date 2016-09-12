//
//  SearchResultViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultViewController.h"

#import "SearchResultModel.h"

#import "Macro.h"
#import "UIViewController+PopGesture.h"
#import "TabBar.h"

#import "VideoViewController.h"
#import "SearchPromptsViewController.h"
#import "AllVideoViewController.h"
#import "OtherSearchRegionViewController.h"

@interface SearchResultViewController()<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITextFieldDelegate,AllVideoViewControllerDelegate>

@end


@implementation SearchResultViewController{
    SearchResultModel *model;
    NSString* _keyWord;
    
    UITextField* searchTextField;
    UIButton* cancelBtn;
    
    TabBar* tabBar;
    UIScrollView* searchResultScrollView;
    NSMutableArray<UIViewController *>* searchResultViews;
    AllVideoViewController* allVideoViewController;
}
-(instancetype)initWithKeyword:(NSString*)keyword{
    if (self = [super init]) {
        _keyWord = keyword;
        model = [[SearchResultModel alloc] init];
        model.keyword =  keyword;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor =  UIStyleBackgroundColor;
    [cancelBtn setTitleColor:UIStyleColourBtnColor forState:UIControlStateNormal];
    
    tabBar.backgroundColor = UIStyleBackgroundColor;
    tabBar.tintColorRGB = [UIStyleMacro share].SearchResultTabBarTintColor;
    tabBar.selTintColorRGB = [UIStyleMacro share].SearchResultTabBarCelTintColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadSubviews];
    [self loadActions];
    [model getSearchResultPageinfoWithSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [tabBar setTitle:[NSString stringWithFormat:@"番剧(%lu)",model.seasonCount>99?99:model.seasonCount] forIndex:1];
            [tabBar setTitle:[NSString stringWithFormat:@"UP主(%lu)",model.upuserCount>99?99:model.upuserCount] forIndex:2];
            [tabBar setTitle:[NSString stringWithFormat:@"影视(%lu)",model.movieCount>99?99:model.movieCount] forIndex:3];
            [tabBar setTitle:[NSString stringWithFormat:@"专题(%lu)",model.specialCount>99?99:model.specialCount] forIndex:4];
        });
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    [self isAVID];
}
-(void)loadActions{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [[searchResultViews firstObject].view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
 
    searchTextField.delegate = self;
    
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    searchResultScrollView.delegate = self;
    
    __weak UIScrollView* scrollView = searchResultScrollView;
    [tabBar setOnClickItem:^(NSInteger idx) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * idx, 0) animated:YES];
    }];
    
    allVideoViewController.delegate = self;
}
#pragma AllVideoViewControllerDelegate
-(void)findMoreMovie{
     __weak UIScrollView* scrollView = searchResultScrollView;
    [scrollView setContentOffset:CGPointMake(scrollView.width * 3, 0) animated:YES];
}

-(void)findMoreSeason{
    __weak UIScrollView* scrollView = searchResultScrollView;
    [scrollView setContentOffset:CGPointMake(scrollView.width * 1, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    tabBar.contentOffset = scrollView.contentOffset.x / scrollView.width;
}
#pragma Actions
-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)isAVID{
    [model addHistoryWord:_keyWord];
    searchTextField.text = _keyWord;
    
    if (_keyWord.length>2&&[@"av" isEqualToString:[_keyWord substringToIndex:2]]) {
        NSString* string = [_keyWord substringFromIndex:2];
        NSInteger val = [string integerValue];
        if(val&&[[NSString stringWithFormat:@"%lu",val] isEqualToString:string]){
            [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:val] animated:YES];
        }
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchPromptsViewController* sp = [[SearchPromptsViewController alloc] initWithKeyword:searchTextField.text];
    [self.navigationController pushViewController:sp animated:NO];
     [self removeFromParentViewController];
    return NO;
}
#pragma loadSubviews
- (void)loadSubviews{
    searchTextField = ({
        UIImageView *imageview =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_search_tf_left_btn"]];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.frame = CGRectMake(0, 0, 30, 15);
        
        UITextField* tf = [[UITextField alloc] init];
        tf.leftView = imageview;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView.alpha = 0.5;
        
        tf.backgroundColor = ColorRGB(255, 255, 255);
        [tf.layer setCornerRadius:4.0];
        tf.returnKeyType = UIReturnKeySearch;
        [tf setFont:[UIFont systemFontOfSize:14]];
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.textColor = ColorRGB(50, 50, 50);
        UIColor *color = ColorRGB(179, 179, 179); //设置默认字体颜色
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号" attributes:@{NSForegroundColorAttributeName: color}];
        [self.view addSubview:tf];
        tf;
    });
    
    cancelBtn = ({
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:btn];
        btn;
    });
    searchResultScrollView = ({
        UIScrollView* scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, SSize.width, SSize.height-104)];
        scr.contentSize = CGSizeMake(SSize.width*5, 0);
        scr.showsHorizontalScrollIndicator = NO;
        scr.pagingEnabled = YES;
        [self.view addSubview:scr];
        scr;
    });
    
    tabBar = ({
        TabBar* tb = [[TabBar alloc] initWithTitles:@[@"综合",@"番剧",@"UP主",@"影视",@"专题"] style:TabBarStyleNormal];
        tb.edgeInsets = UIEdgeInsetsMake( 0, 0, 2, 0);
        [self.view addSubview:tb];
        tb;
    });
    
    searchResultViews = [[NSMutableArray alloc] init];
    allVideoViewController = [[AllVideoViewController alloc] initWithKeyword:_keyWord];
    [searchResultViews addObject:allVideoViewController];
    [searchResultViews addObject:[[OtherSearchRegionViewController alloc] initWithType:1 keyword:_keyWord]];
    [searchResultViews addObject:[[OtherSearchRegionViewController alloc] initWithType:2 keyword:_keyWord]];
    [searchResultViews addObject:[[OtherSearchRegionViewController alloc] initWithType:3 keyword:_keyWord]];
    [searchResultViews addObject:[[OtherSearchRegionViewController alloc] initWithType:4 keyword:_keyWord]];
    for (int i = 0; i < searchResultViews.count; i++) {
        UIViewController* table = searchResultViews[i];
        [self addChildViewController:table];
        table.view.backgroundColor = ColorWhite(243);
        [searchResultScrollView addSubview:table.view];
        [table.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(searchResultScrollView.width*i);
            make.width.mas_equalTo(searchResultScrollView.width);
            make.top.equalTo(searchResultScrollView);
            make.height.equalTo(searchResultScrollView);
        }];
    }
    
    // Layout
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.right.mas_equalTo(cancelBtn.mas_left).offset(-5);
        make.centerY.equalTo(cancelBtn);
        make.height.mas_equalTo(28);
    }];
    [cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchTextField.mas_right).offset(5);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.right.mas_equalTo(self.view).offset(-5);
    }];
    
    [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBtn.mas_bottom);
        make.height.equalTo(@40);
        make.left.right.equalTo(self.view);
    }];
    
    [searchResultScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}
@end
