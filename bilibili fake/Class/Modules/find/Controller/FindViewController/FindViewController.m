//
//  FindEntityViewController.m
//  bilibili fake
//
//  Created by C on 16/6/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindViewController.h"
#import "Masonry.h"
#import <ReactiveCocoa.h>
#import "Macro.h"
#import "JCTagListView.h"
#import "FindViewCell.h"
#import "FindViewData.h"
#import "GameCentreVC.h"
#import "ReadRQCodeVC.h"
#import "ScrollTabBarController.h"
#import "SearchResultVC.h"
#import "SearchPromptsVC.h"
#import "RankOriginalorAllVC.h"
#import "UIView+CornerRadius.h"

#define FinViewCell_Height 60
@interface FindViewController ()

@end

typedef enum : NSUInteger {
    search_closeMore,
    search_openMore,
} TagListViewMode;

@implementation FindViewController{
    TagListViewMode tagListViewMode;
    NSArray* FindViewTableViewData;
    NSArray* keywordArr;
    
    
    UIView* HeadView;
    UIButton *QRcode_btn;
    UITextField* search_tf;
    UIImageView* search_left_imageview;
    UIView* contentView;
    UILabel* label1;
    JCTagListView* tagListView;
    UIButton* tagList_btn;
    UIImageView *btnbg_imageView;
    UITableView* tabelView;
    
}
- (instancetype)init; {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_discovery_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_discovery_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationController.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: UIStyleForegroundColor,
      NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};  //标题颜色和字体
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    self.view.backgroundColor = UIStyleBackgroundColor;
    QRcode_btn.tintColor = UIStylePromptLabelColor;
    label1.textColor = UIStylePromptLabelColor;
    [tagList_btn setTitleColor:UIStylePromptLabelColor forState:UIControlStateNormal];
    tagList_btn.tintColor = UIStylePromptLabelColor;
    tagListView.tagTextColor = UIStyleForegroundColor;
    tagListView.tagBackgroundColor = UIStyleJCTagCellBg;
//    HeadView.backgroundColor = UIStyleBackgroundColor;
//    QRcode_btn.backgroundColor = UIStyleBackgroundColor;
    [tabelView layoutIfNeeded];
    [tabelView cornerRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight withCornerRadius:5];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    tagListViewMode = search_closeMore;
    FindViewTableViewData = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FindViewController" ofType:@"plist"]] objectForKey:@"FindViewTableViewData"];
    keywordArr = [[NSArray alloc] init];
    
    [self loadSubviews];
    [self loadActions];
    
    
}



- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - ActionDealt
-(void)loadActions{
    //二维码按钮
    QRcode_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"调用二维码界面");
        ReadRQ_CodeVC* gamevc = [[ReadRQ_CodeVC alloc] init] ;
        
        [self.navigationController pushViewController:gamevc animated:YES];
        return [RACSignal empty];
    }];
    
     //标签视图
    __block FindViewController *blockSelf = self;
    [tagListView setCompletionBlockWithSelected:^(NSInteger index) {
        [blockSelf.navigationController pushViewController:[[SearchResultVC alloc] initWithkeyword: blockSelf->keywordArr[index]] animated:NO];
    }];
    
     //展开收起按钮
    tagList_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (tagListViewMode == search_closeMore) {
            tagListViewMode = search_openMore;
//            [UIView animateWithDuration:0.1 animations:^{
                [self TagListView_open];
                [tagListView layoutIfNeeded];
//            }];
        }else{
            tagListViewMode = search_closeMore;
//            [UIView animateWithDuration:0.1 animations:^{
                [self TagListView_close];
                [tagListView layoutIfNeeded];
//            }];
        }
        
        return [RACSignal empty];
    }];
    
    
}


//标签视图关闭时
-(void)TagListView_close{
    [tagList_btn setTitle:@" 查看更多" forState:UIControlStateNormal];
    [tagList_btn setImage:[UIImage imageNamed:@"search_openMore"] forState:UIControlStateNormal];
    [tagListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(10);
        make.right.mas_equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(@80);
    }];
    
}
//标签视图展开时
-(void)TagListView_open{
    [tagList_btn setTitle:@" 收起" forState:UIControlStateNormal];
    [tagList_btn setImage:[UIImage imageNamed:@"search_closeMore"] forState:UIControlStateNormal];
    [tagListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(10);
        make.right.mas_equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(@200);
    }];
    
}






#pragma mark - GestureRecognizer

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
        ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
        [tabbar handlePanGesture:panGestureRecognizer];

}

#pragma UITextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [search_tf resignFirstResponder];
    [self.navigationController pushViewController:[[SearchResultVC alloc] initWithkeyword:@""] animated:NO];
    [self.navigationController pushViewController:[[SearchPromptsVC alloc] initWithKeyword:@""] animated:NO];
}


#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* arr = FindViewTableViewData[indexPath.section];
    NSDictionary* dic = arr[indexPath.row];
    NSString* title = [dic objectForKey:@"title"];
    if ([title isEqualToString:@"游戏中心"]) {
        GameCentreVC* gamevc = [[GameCentreVC alloc] init] ;
        [self.navigationController pushViewController:gamevc animated:NO];
    }else if([title isEqualToString:@"原创排行榜"]){
        RankOriginalorAllVC* gamevc = [[RankOriginalorAllVC alloc] initWithType:RankOriginal];
        [self.navigationController pushViewController:gamevc animated:NO];
    }else if([title isEqualToString:@"全区排行榜"]){
        RankOriginalorAllVC* gamevc = [[RankOriginalorAllVC alloc] initWithType:RankAll];
        [self.navigationController pushViewController:gamevc animated:NO];
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FinViewCell_Height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?5.0:0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return FindViewTableViewData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* arr = FindViewTableViewData[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"FindViewCell";

    FindViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FindViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;    
        NSArray* arr = FindViewTableViewData[indexPath.section];
        NSDictionary* dic = arr[indexPath.row];
        [cell setIconImage:[UIImage imageNamed:[dic objectForKey:@"icon"]] TitleText:[dic objectForKey:@"title"]];
    }
    
    return cell;
}









#pragma mark Subviews
- (void)loadSubviews {

    
    //头视图
    HeadView = UIView.new;
    [self.view addSubview:HeadView];
    
    
    
    //二维码按钮
    QRcode_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [QRcode_btn setImage:[UIImage imageNamed:@"search_qr"] forState:UIControlStateNormal];
    [HeadView addSubview:QRcode_btn];
    

    
    //搜索输入栏
    search_tf = UITextField.new;
    search_left_imageview =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_search_tf_left_btn"]];
    search_left_imageview.contentMode = UIViewContentModeScaleAspectFit;
    search_left_imageview.frame = CGRectMake(0, 0, 30, 20);
    search_tf.leftView = search_left_imageview;
    search_tf.leftViewMode = UITextFieldViewModeAlways;
    search_tf.backgroundColor = ColorRGB(255, 255, 255);
    [search_tf.layer setCornerRadius:4.0];
    search_tf.delegate = self;
    [search_tf setFont:[UIFont systemFontOfSize:15]];
    [search_tf.layer setBorderWidth:0.1];
    search_tf.clearButtonMode = UITextFieldViewModeAlways;//右方的小叉
    search_tf.textColor = [UIColor grayColor];
    UIColor *color = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1]; //设置默认字体颜色
    search_tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号"
                                                                      attributes:@{NSForegroundColorAttributeName: color}];
    [HeadView addSubview:search_tf];
    
    
   
    

    
    
    //底部内容视图
    contentView = UIView.new;
    [self.view addSubview:contentView];

    //大家都在搜
    label1 = UILabel.new;
    label1.text = @"大家都在搜";
    label1.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:label1];

    
    //标签视图
    tagListView = JCTagListView.new;
    [contentView addSubview:tagListView];
    tagListView.tagCornerRadius = 5.0f;
   
    
    
    [FindViewData getKeyword:^(NSArray *keyword_arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [tagListView.tags addObjectsFromArray:keyword_arr];
            [[tagListView collectionView] reloadData];
        });
        
        keywordArr = [[NSArray alloc] initWithArray:keyword_arr];
        
    }];
    

    
    //展开收起按钮
    btnbg_imageView =  [UIImageView new];
    btnbg_imageView.image = [UIImage imageNamed:@"search_moreLine"];
    [contentView addSubview:btnbg_imageView];
    
    tagList_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    tagList_btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [tagList_btn setTitle:@" 查看更多" forState:UIControlStateNormal];
    [tagList_btn setImage:[UIImage imageNamed:@"search_closeMore"] forState:UIControlStateNormal];
    [contentView addSubview:tagList_btn];


    
    //列表
    tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];//设置页眉没粘性
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [contentView addSubview:tabelView];
//    tabelView.scrollEnabled = NO;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.backgroundColor = ColorRGB(243, 243, 243);
//    tabelView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
    
    // Layout
    [HeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.width.equalTo(self.view);
        make.left.top.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
    }];

    [QRcode_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HeadView.mas_left).offset(10);
        make.top.mas_equalTo(HeadView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [search_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(QRcode_btn.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(28);
        make.bottom.mas_equalTo(HeadView.mas_bottom).offset(-8);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    }];

    
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeadView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeadView.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(10);
        make.right.mas_equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(@10);
    }];
    
    [tagListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(0);
        make.right.mas_equalTo(contentView.mas_right).offset(-0);
        make.height.equalTo(@80);
    }];
    
    [btnbg_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tagList_btn.mas_centerY);
        make.left.mas_equalTo(contentView.mas_left).offset(10);
        make.right.mas_equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(@1);
    }];
    
    [tagList_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tagListView.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(10);
        make.right.mas_equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [tabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tagList_btn.mas_bottom).offset(0);
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView).offset(100);
    }];
    
    
}
@end
