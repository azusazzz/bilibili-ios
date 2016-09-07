//
//  SearchResultVC.m
//  bilibili fake
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultVC.h"
#import "RowBotton.h"
#import "SearchResultData.h"
#import <ReactiveCocoa.h>
#import "SearchPromptsVC.h"
#import "RowBotton.h"
#import "Macro.h"
#import "NonVideoCell.h"
#import "VideoCell.h"
#import <Masonry.h>
#import "SearchAnimateView.h"
#import <UIImageView+WebCache.h>
#import "VideoViewController.h"


typedef NS_ENUM(NSUInteger, RefreshState) {
    RefreshStateNormal,//正常
    RefreshStatePulling,//释放即可刷新
    RefreshStateLoading,//加载中
};
struct tablePoint{
    NSInteger X;
    NSInteger x1;
    NSInteger x2;
} ;



@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,assign)RefreshState tableViewRefreshState;
@end

@implementation SearchResultVC{
    UITextField* search_tf;
    UIButton* cancel_btn;
    NSString* _keyword;
    
    RowBotton* rowbtn;
    UIButton* screen_btn;
    BOOL isScreen;
   
    UIView* screen_view;
    RowBotton* screen_rowbtn1;
    RowBotton* screen_rowbtn2;
    
    UITableView* _tableView;
    UIImageView* _tableViewRefresh_animation;
    UIImageView* _tableViewRefresh_imageview;
    UILabel* _tableViewRefresh_label;
    SearchAnimateView* _animateView;

    SearchResultData* _searchResultData;
    
    NSMutableArray* _tableViewData_bangumi_arr;
    NSMutableArray* _tableViewData_arr;
    
}


-(instancetype)initWithkeyword:(NSString*)keyword{
    
    NSLog(@"关键字：%@",keyword);
    [SearchResultData addSearchRecords:keyword];
   
    self = [super init];
    if (self) {
        //self.view.backgroundColor = ColorRGBA(0, 0, 0, 0);
        isScreen = NO;
        _keyword = keyword;
        
        _searchResultData = [[SearchResultData alloc] initWithKeyword:_keyword];
    
        _tableViewData_arr = [[NSMutableArray alloc] init];
        _tableViewData_bangumi_arr = [[NSMutableArray alloc] init];
        
        [self loadSubviews];
        [self loadActions];
        
         _tableViewRefreshState = RefreshStateNormal;
        [_searchResultData getPageinfo:^(NSInteger bangumiCount, NSInteger specialCount, NSInteger upuserCount) {
            NSMutableArray* arr= [[NSMutableArray alloc] initWithObjects:@"综合", nil];
            [arr addObject:[NSString stringWithFormat:@"番剧(%lu)",bangumiCount]];
            [arr addObject:[NSString stringWithFormat:@"专题(%lu)",specialCount]];
            [arr addObject:[NSString stringWithFormat:@"UP主(%lu)",upuserCount]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [rowbtn setTitles:arr];
            });
        }];

        [self SearchAndUPdata];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     dispatch_async(dispatch_get_main_queue(), ^{
         [search_tf setText:_keyword];
     });
}

#pragma mark - ActionDealt
//设置关键字
-(void)setSearchKeyword:(NSNotification*)notification{

    NSString* keyword = [notification.userInfo objectForKey:@"keyword"];
    NSLog(@"关键字：%@",keyword);
    //if ([keyword isEqualToString:_keyword])  return;
    if (keyword.length == 0) return;
    
    
    [search_tf setText:keyword];
    _keyword = keyword;
    
    
    [SearchResultData addSearchRecords:keyword];
    [_searchResultData setKeyword:keyword];
    [_searchResultData getPageinfo:^(NSInteger bangumiCount, NSInteger specialCount, NSInteger upuserCount) {
        NSMutableArray* arr= [[NSMutableArray alloc] initWithObjects:@"综合", nil];
        [arr addObject:[NSString stringWithFormat:@"番剧(%lu)",bangumiCount]];
        [arr addObject:[NSString stringWithFormat:@"专题(%lu)",specialCount]];
        [arr addObject:[NSString stringWithFormat:@"UP主(%lu)",upuserCount]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [rowbtn setTitles:arr];
        });
    }];
    
    [self SearchAndUPdata];
}


-(void)loadActions{
    //取消按钮
    __weak typeof(self) weakSelf = self;
    cancel_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [weakSelf.navigationController popViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
        return [RACSignal empty];
    }];
    
    //分区按钮
    //__block SearchResultVC *BlockSelf = self;
    [rowbtn setSelecteBlock:^(NSInteger btnTag) {
        //隐藏筛选视图
        if (btnTag)[weakSelf screen_view_hide];
        
        [weakSelf SearchAndUPdata];
    }];
    
    //筛选开关按钮
    [screen_btn addTarget:self action:@selector(screen_btn_Action) forControlEvents:UIControlEventTouchUpInside];
    
    [screen_rowbtn1 setSelecteBlock:^(NSInteger btnTag) {
        [weakSelf SearchAndUPdata];
    }];
    [screen_rowbtn2 setSelecteBlock:^(NSInteger btnTag) {
        [weakSelf SearchAndUPdata];
    }];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSearchKeyword:) name:@"setSearchKeyword" object:nil];
}
//筛选按钮
-(void)screen_btn_Action{
    //筛选视图隐藏和显示
    if (rowbtn.Selectedtag == 0){
        if (isScreen) {
            [self screen_view_hide];
        }else{
            
            screen_btn.tintColor = ColorRGB(252, 142, 175);
            [screen_view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(rowbtn.mas_bottom);
                make.left.right.mas_equalTo(self.view);
                make.height.equalTo(@70);
            }];
            
          isScreen = (!isScreen);
        }
    }

}

//筛选View隐藏
-(void)screen_view_hide{
    if (isScreen == NO) return;
    
    screen_btn.tintColor = ColorRGB(100, 100, 100);

    [screen_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rowbtn.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.equalTo(@0);
    }];

    isScreen = (!isScreen);
}

//请求搜索结果 设置tableview数据
-(void)SearchAndUPdata{
    [self SearchAndUPdata:nil];
}

-(void)SearchAndUPdata:(void(^)())completeBlock{
    if (_keyword.length == 0) return;
    
    _tableViewData_arr = [[NSMutableArray alloc] init];
    _tableViewData_bangumi_arr = [[NSMutableArray alloc] init];
    [_tableView reloadData];
    //播放动画
    [_animateView inSearch];
    
    //防止请求成功的时候用户已经改变筛选项了
    struct tablePoint oldTablePoint;
    oldTablePoint.X = rowbtn.Selectedtag;
    oldTablePoint.x1 = screen_rowbtn1.Selectedtag;
    oldTablePoint.x2 = screen_rowbtn2.Selectedtag;
    
    if (rowbtn.Selectedtag) {
        //设置番剧，专题，up数据
        NSString* typeName = @"";
        switch (rowbtn.Selectedtag) {
            case 1: typeName = @"bangumi"; break;//@"番剧"
            case 2: typeName = @"special"; break;//@"专题"
            case 3: typeName = @"upuser"; break;//@"UP主"
            default:
                break;
        }
        
        
        [_searchResultData getNonVideoSearchResultData_arr:typeName Success:^(NSMutableArray *SearchResultData_arr) {
//            NSLog(@"%lu",SearchResultData_arr.count);
            _tableViewData_arr = SearchResultData_arr;
            dispatch_async(dispatch_get_main_queue(), ^{
                if(oldTablePoint.X==rowbtn.Selectedtag||oldTablePoint.x1==screen_rowbtn1.Selectedtag||oldTablePoint.x2==screen_rowbtn2.Selectedtag){
                    if (_tableViewData_arr.count) {
                        [_animateView hide];
                    }else{
                        [_animateView noResult];
                    }
                    [_tableView reloadData];
                    if(completeBlock)completeBlock();
                }
            });
        } Error:^(NSError *error) {
            NSLog(@"code:%lu.%@",[error code],[error localizedDescription]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(oldTablePoint.X==rowbtn.Selectedtag||oldTablePoint.x1==screen_rowbtn1.Selectedtag||oldTablePoint.x2==screen_rowbtn2.Selectedtag){
                    if(completeBlock)completeBlock();
                    [_animateView eorro:[error code]];
                }
            });
        }];
        
    }else{
        
        [_searchResultData getVideoSearchResultData_arr:[screen_rowbtn2 getSelected_button].titleLabel.text Tid_name:[screen_rowbtn1 getSelected_button].titleLabel.text Success:^(NSMutableArray *SearchResultData_arr, NSMutableArray* bangumiSearchResultData_arr) {
            NSLog(@"%lu",SearchResultData_arr.count);
            _tableViewData_arr = SearchResultData_arr;
            _tableViewData_bangumi_arr = bangumiSearchResultData_arr;
            dispatch_async(dispatch_get_main_queue(), ^{
                if(oldTablePoint.X==rowbtn.Selectedtag||oldTablePoint.x1==screen_rowbtn1.Selectedtag||oldTablePoint.x2==screen_rowbtn2.Selectedtag){
                    if (_tableViewData_arr.count) {
                        [_animateView hide];
                    }else{
                        [_animateView noResult];
                    }
                    [_tableView reloadData];
                    if(completeBlock)completeBlock();
                }
            });
        } Error:^(NSError *error) {
            NSLog(@"code:%lu.%@",[error code],[error localizedDescription]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(oldTablePoint.X==rowbtn.Selectedtag||oldTablePoint.x1==screen_rowbtn1.Selectedtag||oldTablePoint.x2==screen_rowbtn2.Selectedtag){
                    if(completeBlock)completeBlock();
                    [_animateView eorro:[error code]];
                }
            });
        }];
        
    }
}





#pragma UITextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [search_tf resignFirstResponder];
    SearchPromptsVC* savc = [[SearchPromptsVC alloc] initWithKeyword:search_tf.text];
    [self.navigationController pushViewController:savc animated:NO];
}
#pragma UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部加载更多
    
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - scrollView.frame.size.height) {
        NSLog(@"快滑到底部加载更多");
      
        //防止请求成功刷新界面的时候用户已经改变筛选项了
        struct tablePoint oldTablePoint;
        oldTablePoint.X = rowbtn.Selectedtag;
        oldTablePoint.x1 = screen_rowbtn1.Selectedtag;
        oldTablePoint.x2 = screen_rowbtn2.Selectedtag;
        
        
        if (rowbtn.Selectedtag) {
            //设置番剧，专题，up数据
            NSString* typeName = @"";
            switch (rowbtn.Selectedtag) {
                case 1: typeName = @"bangumi"; break;//@"番剧"
                case 2: typeName = @"special"; break;//@"专题"
                case 3: typeName = @"upuser"; break;//@"UP主"
                default:
                    break;
            }
            
            
            [_searchResultData getMoreNonVideoSearchResultData_arr:typeName Success:^(NSMutableArray *SearchResultData_arr) {
                NSLog(@"%lu",SearchResultData_arr.count);
                _tableViewData_arr = SearchResultData_arr;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
            
        }else{
            //设置视频
            
            [_searchResultData getMoreVideoSearchResultData_arr:[screen_rowbtn2 getSelected_button].titleLabel.text Tid_name:[screen_rowbtn1 getSelected_button].titleLabel.text Success:^(NSMutableArray *SearchResultData_arr) {
                NSLog(@"%lu",SearchResultData_arr.count);
                _tableViewData_arr = SearchResultData_arr;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
            
            
            
        }
        
        
    }
    //下拉顶部刷新
    if(scrollView.contentOffset.y < -120){
        if(_tableViewRefreshState == RefreshStateNormal){//小于临界值（在触发点以下），如果状态是正常就转为下拉刷新，如果正在刷新或者已经是下拉刷新则不变
            [self settableViewRefreshState:RefreshStatePulling];
        }
    }else{//大于临界值（在触发点以上，包括触发点）
        if(scrollView.isDragging){//手指没有离开屏幕
            if(_tableViewRefreshState == RefreshStatePulling){//原来是下拉的话变成正常，原来是刷新或者正常的话不变
                [self settableViewRefreshState:RefreshStateNormal];
            }
        }else{//手指离开屏幕
            if(_tableViewRefreshState == RefreshStatePulling){//原来是下拉的话变成加载中，原来是加载中或者正常的话不变
                _tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);//改变contentInset的值就可以取消回弹效果停留在当前位置了 关于contentIinset的介绍，可以查看我的上一篇文章
                 [self settableViewRefreshState:RefreshStateLoading];
            }
        }
    
    }
}

- (void)settableViewRefreshState:(RefreshState)refreshState{
    _tableViewRefreshState = refreshState;
    __block SearchResultVC *BlockSelf = self;
    switch (refreshState) {
        case RefreshStateNormal:
            _tableViewRefresh_label.text = @"再拉，再拉就刷新给你看";
            [UIView animateWithDuration:0.2 animations:^{
                BlockSelf->_tableViewRefresh_imageview.transform = CGAffineTransformRotate(BlockSelf->_tableViewRefresh_imageview.transform, M_PI);
            }];
            break;
        case RefreshStateLoading:
            BlockSelf->_tableViewRefresh_label.text = @"正在刷新...";
            [BlockSelf->_tableViewRefresh_animation startAnimating];
            
            [self SearchAndUPdata:^{
                [BlockSelf settableViewRefreshState:RefreshStateNormal];
                [BlockSelf->_tableViewRefresh_animation stopAnimating];
                [UIView animateWithDuration:0.2 animations:^{
                    BlockSelf->_tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                } completion:nil];
            }];
           
            break;
        case RefreshStatePulling:
            BlockSelf->_tableViewRefresh_label.text = @"够了啦，松开人家嘛";
            [UIView animateWithDuration:0.2 animations:^{
               BlockSelf->_tableViewRefresh_imageview.transform = CGAffineTransformRotate(BlockSelf->_tableViewRefresh_imageview.transform, M_PI);
            }];
            break;
        default:
            break;
    }
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (rowbtn.Selectedtag == 0){
        //前三个番剧
        if(_tableViewData_bangumi_arr.count &&indexPath.section == 0 && screen_rowbtn1.Selectedtag == 0 && screen_rowbtn2.Selectedtag == 0) {
            NSLog(@"%@",_tableViewData_bangumi_arr[indexPath.row]);
            return;
        }
        //普通视频
        NSDictionary* data = _tableViewData_arr[indexPath.row];
        NSLog(@"%@",_tableViewData_arr[indexPath.row]);
        [self.navigationController pushViewController:[[VideoViewController alloc] initWithAid:[[data objectForKey:@"aid"] integerValue]] animated:YES];
         return;
    }
    
    //番剧，专题，upuser
    NSLog(@"%@",_tableViewData_arr[indexPath.row]);
    return;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rowbtn.Selectedtag == 0){
        if(_tableViewData_bangumi_arr.count &&indexPath.section == 0 && screen_rowbtn1.Selectedtag == 0 && screen_rowbtn2.Selectedtag == 0){
           return 100;
        }
        return 80;
    }
    return 100;
}
//页眉高度(不能为0)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
//页脚高度(不能为0)
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (rowbtn.Selectedtag == 0 && _tableViewData_bangumi_arr.count && screen_rowbtn1.Selectedtag == 0 && screen_rowbtn2.Selectedtag == 0){
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (rowbtn.Selectedtag == 0 && _tableViewData_bangumi_arr.count && screen_rowbtn1.Selectedtag == 0 && screen_rowbtn2.Selectedtag == 0 &&section == 0){
        return _tableViewData_bangumi_arr.count;
    }
    return _tableViewData_arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (rowbtn.Selectedtag == 0){
        //前三个番剧
        if(_tableViewData_bangumi_arr.count &&indexPath.section == 0 && screen_rowbtn1.Selectedtag == 0 && screen_rowbtn2.Selectedtag == 0) {
            NonVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NonVideoCell"];
            if (!cell) {
                cell = [[NonVideoCell alloc] init];
                [cell setData:_tableViewData_bangumi_arr[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        //普通视频
        VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
        if (!cell) {
            cell = [[VideoCell alloc] initWithData:_tableViewData_arr[indexPath.row] order:[screen_rowbtn2 getSelected_button].titleLabel.text];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    
    //番剧，专题，upuser
    NonVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NonVideoCell"];
    if (!cell) {
            cell = [[NonVideoCell alloc] init];
            [cell setData:_tableViewData_arr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
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
    //中间的那条分隔线
    UIView* screen_btn_SplitLine = [UIView new];
    screen_btn_SplitLine.backgroundColor = ColorRGB(100, 100, 100);
    [screen_btn addSubview:screen_btn_SplitLine];
    
    
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
    
    //列表
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];//设置页眉没粘性
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //下拉刷新显示界面
    _tableViewRefresh_imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_openMore"]];
    [_tableView addSubview:_tableViewRefresh_imageview];
    
    _tableViewRefresh_animation = [UIImageView new];
    _tableViewRefresh_animation.image = ImageWithName(@"common_pay_loading_1");
    _tableViewRefresh_animation.animationDuration = 2.0;//设置动画总时间
    _tableViewRefresh_animation.animationRepeatCount= -1; //设置重复次数，0表示不重复
    _tableViewRefresh_animation.animationImages=[NSArray arrayWithObjects:
                      ImageWithName(@"common_pay_loading_1"),
                      ImageWithName(@"common_pay_loading_2"),
                      ImageWithName(@"common_pay_loading_3"),
                      ImageWithName(@"common_pay_loading_4"),
                      ImageWithName(@"common_pay_loading_5"),
                      ImageWithName(@"common_pay_loading_6"),
                      ImageWithName(@"common_pay_loading_7"),
                      ImageWithName(@"common_pay_loading_8"),nil];
    [_tableView addSubview:_tableViewRefresh_animation];
    
    
    _tableViewRefresh_label = [[UILabel alloc] init];
    _tableViewRefresh_label.text = @"再拉，再拉就刷新给你看";
    _tableViewRefresh_label.font = [UIFont systemFontOfSize:15];
    _tableViewRefresh_label.textColor = ColorRGB(0, 0, 0);
    _tableViewRefresh_label.textAlignment = NSTextAlignmentCenter;
    [_tableView addSubview:_tableViewRefresh_label];
    
    
    _animateView = [[SearchAnimateView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 48)];
    [_tableView addSubview:_animateView];

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
    [screen_btn_SplitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(screen_btn.mas_left);
        make.centerY.mas_equalTo(screen_btn.mas_centerY);
        make.width.equalTo(@(0.5));
        make.height.mas_equalTo(screen_btn.mas_height).offset(-20);
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
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(screen_view.mas_bottom);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [_tableViewRefresh_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 30));
        make.centerX.equalTo(_tableView.mas_centerX).offset(15);
        make.left.equalTo(_tableViewRefresh_imageview.mas_right);
        make.bottom.equalTo(_tableView.mas_top).equalTo(@(-20));
    }];
    [_tableViewRefresh_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.bottom.equalTo(_tableView.mas_top).equalTo(@(-20));
    }];
    
    [_tableViewRefresh_animation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 60));
        make.centerX.equalTo(_tableView.mas_centerX);
        make.bottom.equalTo(_tableViewRefresh_label.mas_top).equalTo(@(-10));
    }];
    

}

@end
