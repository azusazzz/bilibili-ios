//
//  SearchResultVC.m
//  bilibili fake
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultVC.h"
#import "RowBotton.h"
#import "FindViewData.h"
#import <ReactiveCocoa.h>
#import "SearchAlertVC.h"
#import "RowBotton.h"
#import "Macro.h"

@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation SearchResultVC{
    UITextField* search_tf;
    UIButton* cancel_btn;
    NSString* _keywork;
    
    RowBotton* rowbtn;
    UIButton* screen_btn;
    BOOL isScreen;
    
    UIView* screen_view;
    RowBotton* screen_rowbtn1;
    RowBotton* screen_rowbtn2;
}


-(id)initWithKeywork:(NSString*)keywork{
    
    NSLog(@"%@",keywork);
    [FindViewData addSearchRecords:keywork];
    self = [super init];
    if (self) {
        _keywork = keywork;
        //self.view.backgroundColor = ColorRGBA(0, 0, 0, 0);
        isScreen = NO;
       
        
        [self loadSubviews];
        [self loadActions];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
     self.rippleImageName = @"bg.jpg";
    [super viewDidLoad];
     dispatch_async(dispatch_get_main_queue(), ^{
         [search_tf setText:_keywork];
     });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - ActionDealt
-(void)setKeywork:(NSString*)keywork{
    NSLog(@"%@",keywork);
    [FindViewData addSearchRecords:keywork];
    [search_tf setText:keywork];
}


-(void)loadActions{
    cancel_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        return [RACSignal empty];
    }];
    
    screen_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (rowbtn.Selectedtag == 0){
            if (isScreen) {
                screen_btn.tintColor = ColorRGB(100, 100, 100);
                [screen_view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(rowbtn.mas_bottom);
                    make.left.right.mas_equalTo(self.view);
                    make.height.equalTo(@0);
                }];
            }else{
                screen_btn.tintColor = ColorRGB(252, 142, 175);
                [screen_view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(rowbtn.mas_bottom);
                    make.left.right.mas_equalTo(self.view);
                    make.height.equalTo(@70);
                }];
            }
            isScreen = (!isScreen);
        }

        return [RACSignal empty];
    }];
}


#pragma UITextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    dispatch_async(dispatch_get_main_queue(), ^{
        [search_tf resignFirstResponder];
    });
    SearchAlertVC* savc = [[SearchAlertVC alloc] init];
    [savc setSearch_tf_text:search_tf.text];
    [self.navigationController pushViewController:savc animated:NO];
}


#pragma mark Subviews
- (void)loadSubviews{

    //头视图
    UIView* HeadView = UIView.new;
    [self.view addSubview:HeadView];
    HeadView.backgroundColor = [UIColor whiteColor];
    
    //搜索输入栏
    UIImageView *search_left_imageview =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_search_tf_left_btn"]];
    search_left_imageview.contentMode = UIViewContentModeScaleAspectFit;
    search_left_imageview.frame = CGRectMake(0, 0, 30, 15);
    
    search_tf = UITextField.new;
    search_tf.leftView = search_left_imageview;
    search_tf.leftViewMode = UITextFieldViewModeAlways;
    search_tf.backgroundColor = ColorRGB(229, 229, 229);
    search_tf.leftView.alpha = 0.5;
    [search_tf.layer setCornerRadius:4.0];
    search_tf.delegate = self;
    search_tf.returnKeyType = UIReturnKeySearch;
    [search_tf setFont:[UIFont systemFontOfSize:14]];
    search_tf.clearButtonMode = UITextFieldViewModeAlways;//右方的小叉
    search_tf.textColor = [UIColor grayColor];
    UIColor *color = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1]; //设置默认字体颜色
    search_tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号"
                                                                      attributes:@{NSForegroundColorAttributeName: color}];
    [HeadView addSubview:search_tf];
    
    //取消按钮
    cancel_btn = UIButton.new;
    [cancel_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancel_btn setTitleColor:ColorRGB(252, 142, 175) forState:UIControlStateNormal];
    [HeadView addSubview:cancel_btn];

    
    UIView* rowbtn_bgView = [UIView new];
    rowbtn_bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rowbtn_bgView];
    
    //列按钮
    rowbtn = [[RowBotton alloc] initWithTitles:[[NSMutableArray alloc] initWithArray:@[@"综合",@"番剧(0)",@"专题(0)",@"UP主(0)"]] Block:nil];
    [self.view addSubview:rowbtn];
    
    //筛选开关按钮
    screen_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    screen_btn.tintColor = ColorRGB(100, 100, 100);
    [screen_btn setImage:[UIImage imageNamed:@"search_filter"] forState:UIControlStateNormal];
    [self.view addSubview:screen_btn];
    
    
    //筛选界面
    screen_view = [UIView new];
    screen_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:screen_view];
    
    screen_rowbtn1 = [[RowBotton alloc] initWithTitles:[[NSMutableArray alloc] initWithArray:@[@"全部",@"番剧",@"动画",@"音乐",@"舞蹈",@"游戏",@"科技",@"生活",@"鬼畜"]] Style:RowBottonStyle2 Block:nil];
    [screen_rowbtn1 setSpacing:5];
    [screen_view addSubview:screen_rowbtn1];
    
    screen_rowbtn2 = [[RowBotton alloc] initWithTitles:[[NSMutableArray alloc] initWithArray:@[@"综合",@"点击",@"弹幕",@"评论",@"日期",@"收藏"]] Style:RowBottonStyle2 Block:nil];
    [screen_rowbtn2 setSpacing:5];
    [screen_view addSubview:screen_rowbtn2];
    // Layout
    
    [HeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.width.equalTo(self.view);
        make.left.top.mas_equalTo(0);
    }];
    
    [search_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(28);
        make.bottom.mas_equalTo(HeadView.mas_bottom).offset(-8);
        make.right.mas_equalTo(cancel_btn.mas_left).offset(-5);
    }];
    
    [cancel_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(search_tf.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.width.equalTo(@44);
        make.right.mas_equalTo(HeadView.mas_right).offset(-5);
    }];
    
    [rowbtn_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeadView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.equalTo(rowbtn.mas_height);
    }];
    
    [rowbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeadView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.right.mas_equalTo(screen_btn.mas_left);
        make.width.equalTo(screen_btn.mas_width).multipliedBy(5);
        make.height.equalTo(@40);
    }];
    

    
    [screen_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeadView.mas_bottom);
        make.left.mas_equalTo(rowbtn.mas_right);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.height.mas_equalTo(rowbtn.mas_height);
    }];

    [screen_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rowbtn.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.equalTo(@0);
    }];
    
    [screen_rowbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(screen_view.mas_top);
        make.left.right.mas_equalTo(screen_view);
        make.height.mas_equalTo(screen_view).multipliedBy(0.5);
    }];
    [screen_rowbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(screen_rowbtn1.mas_bottom);
        make.left.right.mas_equalTo(screen_view);
        make.height.mas_equalTo(screen_view).multipliedBy(0.5);
    }];
    
}

@end
