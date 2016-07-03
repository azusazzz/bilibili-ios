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
#import <JCTagListView.h>
#import "FindViewCell.h"
#import "FindViewData.h"
#import "GameCentreVC.h"
#import "SearchAlertView.h"

#define FinViewCell_Height 50
@interface FindViewController ()

@end

typedef enum : NSUInteger {
    View1,
    View2,
    View3,
} ContentViewMode;
typedef enum : NSUInteger {
    search_closeMore,
    search_openMore,
} TagListViewMode;

@implementation FindViewController{
    ContentViewMode contentviewMode;
    TagListViewMode tagListViewMode;
    NSArray* FindViewTableViewData;
    NSArray* keywordArr;
    
    UIScrollView* main_scrollview;
        UIView* main_view;
            UIView* HeadView;
                UIButton *QRcode_btn;
                UITextField* search_tf;
                    UIImageView* search_left_imageview;
                UIButton* cancel_btn;
            UIView* contentView;
                UILabel* label1;
                JCTagListView* tagListView;
                UIButton* tagList_btn;
                UIImageView *btnbg_imageView;
                UITableView* tabelView;
            SearchAlertView* searchAlertView;
}
- (instancetype)init; {
    if (self = [super init]) {
        self.title = @"发现";

    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentviewMode = View1;
    tagListViewMode = search_closeMore;
    FindViewTableViewData = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FindViewController" ofType:@"plist"]] objectForKey:@"FindViewTableViewData"];
    keywordArr = [[NSArray alloc] init];
//最底层视图
    main_scrollview = UIScrollView.new;
    [self.view addSubview:main_scrollview];
    //main_scrollview.frame = self.view.frame;
    [main_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    main_view = [[UIView alloc] init];
    //main_view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    [main_scrollview addSubview:main_view];
    [main_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(main_scrollview);
        make.width.mas_equalTo(main_scrollview);
    }];
  

//头视图
    HeadView = UIView.new;
    [main_view addSubview:HeadView];
    [HeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(main_view);
        make.left.top.mas_equalTo(0);
    }];
    

    //二维码按钮
    QRcode_btn = [[UIButton alloc] init];
    QRcode_btn.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    [QRcode_btn setImage:[UIImage imageNamed:@"search_qr"] forState:UIControlStateNormal];
    [HeadView addSubview:QRcode_btn];
    
    QRcode_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"调用二维码界面");
        return [RACSignal empty];
    }];
    
    //搜索输入栏
    search_tf = UITextField.new;
    search_left_imageview =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_search_tf_left_btn"]];
    search_left_imageview.contentMode = UIViewContentModeScaleAspectFit;
    search_left_imageview.frame = CGRectMake(0, 0, 30, 20);
    search_tf.leftView = search_left_imageview;
    search_tf.leftViewMode = UITextFieldViewModeAlways;
    search_tf.backgroundColor = [UIColor whiteColor];
    [search_tf.layer setCornerRadius:4.0];
    search_tf.returnKeyType = UIReturnKeySearch;
    [search_tf setFont:[UIFont systemFontOfSize:15]];
    search_tf.clearButtonMode = UITextFieldViewModeAlways;//右方的小叉
    UIColor *color = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1]; //设置字体颜色
    search_tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号"
                                                                      attributes:@{NSForegroundColorAttributeName: color}];
    [HeadView addSubview:search_tf];
    
    
    [search_tf.rac_textSignal subscribeNext:^(id x) {
        if([search_tf isFirstResponder]){
            if(contentviewMode==View1){
                [UIView animateWithDuration:0.2 animations:^{
                    [self HeadViewMode2];
                    [HeadView layoutIfNeeded];
                    [cancel_btn layoutIfNeeded];
                }];
            }
            contentviewMode = View2;
            [self contentViewMode_updata];
            [searchAlertView setKeyword:x];
        }
        
        NSLog(@"%@",x);
    }];
    
    //取消按钮
    cancel_btn = UIButton.new;
    [cancel_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancel_btn setTitleColor:ColorRGB(230, 140, 150) forState:UIControlStateNormal];
    [HeadView addSubview:cancel_btn];
    cancel_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        contentviewMode = View1;
        [self contentViewMode_updata];
        [search_tf resignFirstResponder];
        [UIView animateWithDuration:0.2 animations:^{
            [self HeadViewMode1];
            [HeadView layoutIfNeeded];
            [cancel_btn layoutIfNeeded];
        }];
        return [RACSignal empty];
    }];
    
    [self HeadViewMode1];
    
//底部内容视图
    contentView = UIView.new;
    [main_view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeadView.mas_bottom);
        make.width.equalTo(main_view);
        //make.height.equalTo(@600);
    }];
    
    //大家都在搜
    label1 = UILabel.new;
    label1.text = @"大家都在搜";
    label1.textColor = ColorRGB(180, 180, 180);
    label1.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:label1];
    [label1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeadView.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(10);
        make.right.mas_equalTo(contentView.mas_right).offset(-10);
        make.height.equalTo(@10);
    }];
    
    //标签视图
    tagListView = JCTagListView.new;
    [contentView addSubview:tagListView];
    tagListView.tagCornerRadius = 5.0f;
    tagListView.tagTextColor = ColorRGB(27, 27, 27);
    [tagListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(0);
        make.right.mas_equalTo(contentView.mas_right).offset(-0);
        make.height.equalTo(@80);
    }];
    __block FindViewController *blockSelf = self;
    [FindViewData getKeyword:^(NSArray *keyword_arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [tagListView.tags addObjectsFromArray:keyword_arr];
            [[tagListView collectionView] reloadData];
        });

        keywordArr = [[NSArray alloc] initWithArray:keyword_arr];
       
    }];
    
    [tagListView setCompletionBlockWithSelected:^(NSInteger index) {
        NSLog(@"%@", blockSelf->keywordArr[index]);
    }];

    //展开收起按钮
    btnbg_imageView =  [UIImageView new];
    btnbg_imageView.image = [UIImage imageNamed:@"search_moreLine"];
    [contentView addSubview:btnbg_imageView];
    
    tagList_btn = [[UIButton alloc] init];
    tagList_btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [tagList_btn setTitleColor:ColorRGB(144, 144, 144) forState:UIControlStateNormal];
    [tagList_btn setTitle:@" 查看更多" forState:UIControlStateNormal];
    [tagList_btn setImage:[UIImage imageNamed:@"search_closeMore"] forState:UIControlStateNormal];
    
    [contentView addSubview:tagList_btn];
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
    tagList_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (tagListViewMode == search_closeMore) {
            tagListViewMode = search_openMore;
            [UIView animateWithDuration:0.2 animations:^{
                [self TagListView_open];
                [tagListView layoutIfNeeded];
            }];
        }else{
            tagListViewMode = search_closeMore;
            [UIView animateWithDuration:0.2 animations:^{
                [self TagListView_close];
                [tagListView layoutIfNeeded];
            }];
        }
        
        return [RACSignal empty];
    }];

    //列表
    tabelView = [UITableView new];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [contentView addSubview:tabelView];
    tabelView.scrollEnabled = NO;
    [tabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tagList_btn.mas_bottom).offset(0);
            make.left.right.equalTo(contentView);
        make.height.equalTo(@([self getTableViewHeight]-1));
    }];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabelView.mas_bottom);
    }];
    [main_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView.mas_bottom);
    }];
    
}



-(NSInteger)getTableViewHeight{
    NSInteger height = 0;
    for (int i = 0; i < FindViewTableViewData.count; i++) {
        height+=10;
        NSArray* arr = FindViewTableViewData[i];
        height+=(arr.count*FinViewCell_Height);
    }
    return height;
}





-(void)contentViewMode_updata{
    if (contentviewMode == View1) {
        [searchAlertView removeFromSuperview];
        searchAlertView = nil;
        main_scrollview.scrollEnabled = YES;
    }else if(contentviewMode == View2){
        if (searchAlertView == nil) {
            searchAlertView = [[SearchAlertView alloc] init];
            [self.view addSubview:searchAlertView];
            [searchAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view );
                make.top.equalTo(HeadView.mas_bottom);
                make.bottom.equalTo(self.view.mas_bottom).offset(-48);
            }];
        }
    }else if(contentviewMode == View3){
    
    
    }
}


//view1时的headView
-(void)HeadViewMode1{
    main_scrollview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    HeadView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    [search_tf setFont:[UIFont systemFontOfSize:15]];
    search_tf.backgroundColor = ColorRGB(255, 255, 255);
    [search_tf.layer setBorderWidth:0.1];
    search_tf.leftView.alpha = 1.0;
    search_left_imageview.frame = CGRectMake(0, 0, 30, 20);
    [QRcode_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HeadView.mas_left).offset(5);
        make.top.mas_equalTo(HeadView.mas_top);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [search_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(QRcode_btn.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(8);
        make.bottom.mas_equalTo(HeadView.mas_bottom).offset(-8);
        make.right.mas_equalTo(cancel_btn.mas_left).offset(-5);
    }];
    [cancel_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(search_tf.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top);
        make.size.mas_equalTo(CGSizeMake(0, 44));
        make.right.mas_equalTo(HeadView.mas_right).offset(-5);
    }];
}

//view2 view3时的headView
-(void)HeadViewMode2{
    main_scrollview.backgroundColor = [UIColor whiteColor];
    HeadView.backgroundColor = [UIColor whiteColor];
    [search_tf setFont:[UIFont systemFontOfSize:14]];
    search_tf.backgroundColor = ColorRGB(229, 229, 229);
    [search_tf.layer setBorderWidth:0];
    search_tf.leftView.alpha = 0.5;
    search_left_imageview.frame = CGRectMake(0, 0, 30, 15);
    [QRcode_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HeadView.mas_left).offset(5);
        make.top.mas_equalTo(HeadView.mas_top);
        make.size.mas_equalTo(CGSizeMake(0, 44));
    }];
    [search_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(QRcode_btn.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(8);
        make.bottom.mas_equalTo(HeadView.mas_bottom).offset(-8);
        make.right.mas_equalTo(cancel_btn.mas_left).offset(-5);
    }];
    [cancel_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(search_tf.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.width.equalTo(@44);
        make.right.mas_equalTo(HeadView.mas_right).offset(-5);
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


#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* arr = FindViewTableViewData[indexPath.section];
    NSDictionary* dic = arr[indexPath.row];
    NSString* title = [dic objectForKey:@"title"];
    if ([title isEqualToString:@"游戏中心"]) {
        GameCentreVC* gamevc = [[GameCentreVC alloc] init] ;
        
        [self.navigationController pushViewController:gamevc animated:YES];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FinViewCell_Height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
