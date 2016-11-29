//
//  SearchPromptsViewController.m
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchPromptsViewController.h"

#import "Macro.h"
#import "UIViewController+PopGesture.h"

#import "SearchPromptsTableView.h"
#import "SearchPromptsModel.h"
#import "SearchResultViewController.h"
@interface SearchPromptsViewController()<UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>

@end

@implementation SearchPromptsViewController{
    SearchPromptsModel *model;
    
    NSString* _keyword;
    UITextField* searchTextField;
    UIButton* cancelBtn;
    SearchPromptsTableView* tabel;
}
-(instancetype)initWithKeyword:(NSString*)keyword{
    if (self = [super init]) {
        _keyword = keyword;
        model = [[SearchPromptsModel alloc] init];
    }
    return self;
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

    
    [self loadSubviews];
    [self loadActions];
    
}
-(void)loadActions{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self replacingPopGestureRecognizer:panGestureRecognizer];
    
    
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    tabel.delegate = self;
    
    searchTextField.delegate = self;
    [searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma Actions
-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma UITextField
- (void)textFieldDidChange:(UITextField*) sender {
    [tabel setKeyWord:sender.text];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    SearchResultViewController* searchResult = [[SearchResultViewController alloc] initWithKeyword:searchTextField.text];
    [self.navigationController pushViewController:searchResult animated:YES];
    [self removeFromParentViewController];
    return YES;
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    if (translation.x <= fabs(translation.y)) {
        return NO;
    }
    return YES;
}
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (searchTextField.text.length == 0 && indexPath.row == tabel.wordArr.count) {
        [model removeAllHistoryWord];
        [tabel setKeyWord:@""];
    }else{
        SearchResultViewController* searchResult = [[SearchResultViewController alloc] initWithKeyword:tabel.wordArr[indexPath.row]];
        [self.navigationController pushViewController:searchResult animated:YES];
        [self removeFromParentViewController];
    }
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
        
        tf.text = _keyword;
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
        SearchPromptsTableView* view = [[SearchPromptsTableView alloc] initWithModel:model];
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
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
