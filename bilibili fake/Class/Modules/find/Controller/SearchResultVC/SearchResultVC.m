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


@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation SearchResultVC{
    UITextField* search_tf;
    UIButton* cancel_btn;
    NSString* _keywork;
}
-(id)initWithKeywork:(NSString*)keywork{
    
    NSLog(@"%@",keywork);
    [FindViewData addSearchRecords:keywork];
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        [self loadSubviews];
        [self loadActions];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
}


#pragma UITextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [search_tf resignFirstResponder];
     [self.navigationController pushViewController:[[SearchAlertVC alloc] init] animated:NO];
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
    [search_tf setText:_keywork];
    search_tf.leftView = search_left_imageview;
    search_tf.leftViewMode = UITextFieldViewModeAlways;
    search_tf.backgroundColor = ColorRGB(229, 229, 229);
    search_tf.leftView.alpha = 0.5;
    [search_tf.layer setCornerRadius:4.0];
    search_tf.delegate = self;
    search_tf.returnKeyType = UIReturnKeySearch;
    [search_tf setFont:[UIFont systemFontOfSize:15]];
    search_tf.clearButtonMode = UITextFieldViewModeAlways;//右方的小叉
    search_tf.textColor = [UIColor grayColor];
    UIColor *color = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1]; //设置默认字体颜色
    search_tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号"
                                                                      attributes:@{NSForegroundColorAttributeName: color}];
    [HeadView addSubview:search_tf];
    [search_tf setFont:[UIFont systemFontOfSize:14]];
    
    //取消按钮
    cancel_btn = UIButton.new;
    [cancel_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancel_btn setTitleColor:ColorRGB(230, 140, 150) forState:UIControlStateNormal];
    [HeadView addSubview:cancel_btn];

    // Layout
    [HeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.width.equalTo(self.view);
        make.left.top.mas_equalTo(0);
    }];
    
    [search_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(28);
        make.bottom.mas_equalTo(HeadView.mas_bottom).offset(-8);
        make.right.mas_equalTo(cancel_btn.mas_left).offset(-5);
    }];
    [cancel_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(search_tf.mas_right).offset(5);
        make.top.mas_equalTo(HeadView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.width.equalTo(@44);
        make.right.mas_equalTo(HeadView.mas_right).offset(-5);
    }];

}

@end
