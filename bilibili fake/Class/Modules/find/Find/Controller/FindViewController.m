//
//  FindViewController.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindViewController.h"
#import "FindModel.h"


#import "Macro.h"
#import "Masonry.h"
#import "UIView+CornerRadius.h"

#import "HotWorkView.h"
#import "FindTableView.h"

#import "SearchPromptsViewController.h"
#import "SearchResultViewController.h"
#import "QRCodeViewController.h"
#import "GameCenterViewController.h"

@interface FindViewController()<UITableViewDelegate,UITextFieldDelegate>

@end

@implementation FindViewController{
    FindModel* model;
    
    UIButton *QRcodeBtn;
    UITextField* searchTextField;
    
    HotWorkView* hotWorkView;
    FindTableView* findTableView;
}
- (instancetype)init; {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_discovery_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_discovery_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        model = [[FindModel alloc] init];
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
    QRcodeBtn.tintColor = UIStylePromptLabelColor;
    [hotWorkView updateColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle; {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadActions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma loadActions
-(void)loadActions{
    [QRcodeBtn addTarget:self action:@selector(openQRcodeViewController) forControlEvents:UIControlEventTouchUpInside];
    [hotWorkView.openSwitchBtn addTarget:self action:@selector(openHotWorkView) forControlEvents:UIControlEventTouchUpInside];
    
    __block FindViewController *blockSelf = self;
    [hotWorkView.hotWorkListView setCompletionBlockWithSelected:^(NSInteger index) {
        [blockSelf.navigationController pushViewController:[[SearchResultViewController alloc] initWithKeyword:blockSelf->model.hotWorkList.hotWorkList[index].keyword] animated:NO];
    }];
    searchTextField.delegate = self;
    findTableView.delegate = self;
}
#pragma Actions
-(void)openHotWorkView{
    hotWorkView.isOpen = !hotWorkView.isOpen;
}

-(void)openQRcodeViewController{
    [self.navigationController pushViewController:[[QRCodeViewController alloc] init] animated:YES];
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.navigationController pushViewController:[[SearchPromptsViewController alloc] init] animated:NO];
    return NO;
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2&& indexPath.row == 0) {
        [self.navigationController pushViewController:[[GameCenterViewController alloc] init] animated:YES];
    }
}
#pragma loadSubViews
-(void)loadSubViews{
    QRcodeBtn = ({
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[UIImage imageNamed:@"search_qr"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn;
    });
    
    searchTextField = ({
        UITextField* tf = [UITextField new];
        [self.view addSubview:tf];
        
        UIImageView* leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_search_tf_left_btn"]];
        leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        leftImageView.frame = CGRectMake(0, 0, 30, 20);
        tf.leftView = leftImageView;
        tf.leftViewMode = UITextFieldViewModeAlways;
        
        [tf.layer setCornerRadius:4.0];
        [tf.layer setBorderWidth:0.1];
        [tf setFont:[UIFont systemFontOfSize:15]];
        tf.clearButtonMode = UITextFieldViewModeAlways;//右方的小叉
        tf.textColor = [UIColor grayColor];
        tf.backgroundColor = ColorRGB(255, 255, 255);
        UIColor *color = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1]; //设置默认字体颜色
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号"
                                                                          attributes:@{NSForegroundColorAttributeName: color}];
        tf;
    });
    
    hotWorkView = ({
        HotWorkView * hot = [[HotWorkView alloc] init];
        [self.view addSubview:hot];
        //加载数据
        [model getHotWorkListWithSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hot.hotWorkListView.tags addObjectsFromArray:model.hotWorkList.hotWorkStrList];
                [[hot.hotWorkListView collectionView] reloadData];
            });
        } failure:^(NSString *errorMsg) {
            NSLog(@"%@",errorMsg);
        }];
        hot;
    });
                   
    findTableView = ({
        FindTableView* tableView = [[FindTableView alloc] init];
        [self.view addSubview:tableView];
        tableView;
    });
    
    
    //layout
    [QRcodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view .mas_left).offset(10);
        make.top.mas_equalTo(self.view .mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];

    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(QRcodeBtn.mas_right).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.centerY.equalTo(QRcodeBtn);
        make.height.mas_equalTo(28);
    }];
    
    [hotWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRcodeBtn.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(hotWorkView.openSwitchBtn.mas_bottom);
    }];
    
    [findTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotWorkView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
    }];
    
//    [self.view layoutIfNeeded];
//    [findTableView cornerRoundingCorners: UIRectCornerTopLeft|UIRectCornerTopRight  withCornerRadius:5.0];
  
}

@end
