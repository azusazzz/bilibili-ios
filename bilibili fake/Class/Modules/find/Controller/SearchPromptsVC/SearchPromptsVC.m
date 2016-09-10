//
//  SearchPromptsVC.m
//  bilibili fake
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchPromptsVC.h"
#import "SearchPromptsData.h"
#import <ReactiveCocoa.h>
#import "SearchResultVC.h"
#import <Foundation/Foundation.h>

@interface SearchPromptsVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end


@implementation SearchPromptsVC{
    NSMutableArray*  SearchRecords;
    NSString* keyword;//搜索内容
    
    UIView* HeadView;
    UITextField* search_tf;
    UIButton* cancel_btn;
    
    UITableView* _tableView;
    //NSURLSessionDataTask* keyword_task;//关键字搜索任务
    NSMutableArray* SearchPrompts_arr;
    
    
}

-(instancetype)initWithKeyword:(NSString*)str{
    self = [super init];
    //[FindViewData addSearchRecords:@"1"];//调试
    if (self) {

        SearchRecords = [SearchPromptsData getSearchRecords];
        self.view.backgroundColor = ColorRGB(245, 245, 245);
        
        [self loadSubviews];
        search_tf.text = str;
        [self loadActions];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    HeadView.backgroundColor = UIStyleBackgroundColor;
    [cancel_btn setTitleColor:UIStyleColourBtnColor forState:UIControlStateNormal];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC * 200), dispatch_get_main_queue(), ^{
    dispatch_async(dispatch_get_main_queue(), ^{
        [search_tf becomeFirstResponder];
        [self setkeyword:search_tf.text];
    });
//    });
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


-(void)loadActions{
    __weak typeof(self) weakSelf = self;
    cancel_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        [SearchPromptsData clear];
        return [RACSignal empty];
    }];
    [search_tf addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged]; // 监听事件
}

-(void)UpdataView{
    if (keyword.length) {
        _tableView.alpha = 1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    }else{
        
        SearchRecords = [SearchPromptsData getSearchRecords];
        if (SearchRecords.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                _tableView.alpha = 0;
            });
        }else{
            _tableView.alpha = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
        
    }
}

-(void)setkeyword:(NSString*)str{
    if ([keyword isEqualToString:str])return;
    
    keyword = str;
    [self UpdataView];
    
    [SearchPromptsData getSearchPrompts:keyword Block:^(NSMutableArray *Prompts) {
        SearchPrompts_arr = Prompts;
        [self UpdataView];
    }];

    
}

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否是av代码
- (BOOL)isAVID:(NSString*)string{
    if(string.length<=2)return NO;
    
    NSString* str = [string substringToIndex:2];
    NSString* str2 = [string substringFromIndex:2];
    if ([str isEqualToString:@"AV"]||
        [str isEqualToString:@"av"]||
        [str isEqualToString:@"Av"]||
        [str isEqualToString:@"aV"])
    {
        return [self isPureInt:str2];
    }
    return NO;
}
#pragma UITextFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    //通过通知中心发送通知
    NSNotification *notification =[NSNotification notificationWithName:@"setSearchKeyword" object:nil userInfo:@{@"keyword":textField.text}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    return YES;
}

- (void) textFieldDidChange:(UITextField*) sender {
    //NSLog(@"%@",sender.text);
    [self setkeyword:sender.text];
}

#pragma UITableViewDelegate
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(keyword.length == 0){
        if (indexPath.row == SearchRecords.count) {
            keyword = @"";
            [SearchPromptsData clearSearchRecords];
            [self UpdataView];
            [_tableView reloadData];
            return;
        }
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    search_tf.text = cell.textLabel.text;
    NSLog(@"search_tf:%@",search_tf.text);
    //通过通知中心发送通知
    NSNotification *notification =[NSNotification notificationWithName:@"setSearchKeyword" object:nil userInfo:@{@"keyword":cell.textLabel.text}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [SearchPromptsData clear];
    [self.navigationController popViewControllerAnimated:NO];
}
//cell高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40;
//}
//行高
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10.0;
//}
//分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//列数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(keyword.length == 0){//显示搜索记录
        if (SearchRecords.count == 0)return 0;
        
        return SearchRecords.count+1;
        
    }else{//显示关键字提示
        
        if ([self isPureInt:keyword]||[self isAVID:keyword]) {
            return SearchPrompts_arr.count+1;
        }
        return SearchPrompts_arr.count;
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString *identifier;
    UIColor *color = ColorRGB(100, 100, 100);
    if (keyword.length==0) {
        
        //搜索记录
        if (indexPath.row == SearchRecords.count) {
            
            identifier = @"SearchRecords_last";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.textLabel.text = @"清除搜索历史";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
        }else{
            
            identifier = @"SearchRecords";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.imageView.image = [UIImage imageNamed:@"search_history_icon"];
                cell.textLabel.text = SearchRecords[indexPath.row];
            }
        }
        cell.textLabel.textColor = color;
        
        
    }else{
        
        //关键字提示
        BOOL isAVID = NO;
        if ([self isPureInt:keyword]||[self isAVID:keyword]) isAVID = YES;
        
        identifier = @"keywordCell";
        if (indexPath.row == 0||isAVID){
            identifier = @"keywordCell_first";
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.imageView.image = [UIImage imageNamed:@"find_search_tf_left_btn"];
        }
        
        
        if (isAVID ) {
            if (indexPath.row == 0){
                if ([self isPureInt:keyword]) {
                    cell.textLabel.text = [@"av" stringByAppendingString:keyword];
                }else{
                    cell.textLabel.text = [@"av" stringByAppendingString:[keyword substringFromIndex:2]];
                }
                UILabel* label = [UILabel new];
                label.text = @"进入";
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = ColorRGB(230, 140, 150);
                [cell addSubview:label];
                [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.mas_centerY);
                    make.size.mas_equalTo(CGSizeMake(44, 44));
                    make.right.mas_equalTo(cell.mas_right).offset(0);
                }];
            }else{
                NSDictionary* dic = [SearchPrompts_arr valueForKey:[NSString stringWithFormat:@"%lu",indexPath.row-1]];
                cell.textLabel.text = [dic objectForKey:@"name"];
            }
            
        }else{
            NSDictionary* dic = [SearchPrompts_arr valueForKey:[NSString stringWithFormat:@"%lu",indexPath.row]];
            cell.textLabel.text = [dic objectForKey:@"name"];
        }
        
        cell.textLabel.textColor = ColorRGB(50, 50, 50);
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = self.view.backgroundColor;
    
    UIView* bgLine_view = [UIView new];
    bgLine_view.alpha = 0.5;
    bgLine_view.backgroundColor = color;
    [cell addSubview:bgLine_view];
    [bgLine_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(cell);
        make.left.equalTo(cell).offset(15);
        make.height.equalTo(@(0.5));
    }];
    
    return cell;
}

#pragma mark Subviews
- (void)loadSubviews{
    
    //头视图
    HeadView = UIView.new;
    [self.view addSubview:HeadView];

  
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
    search_tf.textColor = ColorRGB(50, 50, 50);
    UIColor *color = ColorRGB(179, 179, 179); //设置默认字体颜色
    search_tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索视频、番剧、up主或AV号"
                                                                      attributes:@{NSForegroundColorAttributeName: color}];
    [HeadView addSubview:search_tf];


    //取消按钮
    cancel_btn = UIButton.new;
    [cancel_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancel_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [HeadView addSubview:cancel_btn];

    
    
    UIImageView* bgImageView = [UIImageView new];
    bgImageView.image = ImageWithName(@"empty_list_no_search_history.jpg");
    [self.view addSubview:bgImageView];
    bgImageView.backgroundColor = ColorRGBA(0, 0, 0,0);
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_centerY);
        make.top.equalTo(HeadView.mas_bottom).offset(50);
//        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(bgImageView.mas_width);
    }];
    
    UILabel* lable = [UILabel new];
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor grayColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"试着搜点什么吧´_>`";
    [self.view addSubview:lable];

    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_tableView];
    _tableView.alpha = 0;
    [self UpdataView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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

    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_centerY);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(bgImageView.mas_width);
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeadView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}



@end
