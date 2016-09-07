//
//  SearchPromptsViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchPromptsViewController.h"
#import "Macro.h"

#import "SearchPromptsTableView.h"
#import "SearchPromptsModel.h"

@interface SearchPromptsViewController()<UITableViewDelegate,UITextFieldDelegate>

@end

@implementation SearchPromptsViewController{
    SearchPromptsModel *model;
    
    UITextField* searchTextField;
    UIButton* cancelBtn;
    SearchPromptsTableView* tabel;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [searchTextField becomeFirstResponder];
    });
    self.view.backgroundColor =  UIStyleBackgroundColor;
   [cancelBtn setTitleColor:UIStyleColourBtnColor forState:UIControlStateNormal];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    model = [[SearchPromptsModel alloc] init];
    
    [self loadSubviews];
    [self loadActions];
}
-(void)loadActions{
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    searchTextField.delegate = self;
    [searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // 监听事件
}

#pragma Actions
-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma UITextFieldDelegate
- (void)textFieldDidChange:(UITextField*) sender {
    if (sender.text.length) {
        [model getPromptsWordArrWithKeyWord:sender.text success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                tabel.isHistoryWordArr = NO;
                tabel.wordArr = model.promptsWordArr;
            });
        } failure:nil];
    }else{
        tabel.isHistoryWordArr = YES;
        tabel.wordArr = model.historyWordArr;
    }
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?10.0:0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    
    tabel = ({
        SearchPromptsTableView* view = [[SearchPromptsTableView alloc] init];
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.wordArr = model.historyWordArr;
        [self.view addSubview:view];
        view;
    });
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
    [tabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBtn.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];
}
@end
