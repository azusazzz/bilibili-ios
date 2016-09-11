//
//  SelectionView.m
//  bilibili fake
//
//  Created by C on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SelectionView.h"


@implementation SelectionView{
    NSInteger SelectedTag;
}

-(instancetype)init{
    if (self = [super init]) {
        SelectedTag = 0;
        _itemArrArr = @[@[@"默认排序",@"播放多",@"新发布",@"弹幕多"],
                        @[@"全部时长",@"1-10分钟",@"10-30分钟",@"30-60分钟",@"60分钟+"],
                        @[@"全部分区",@"番剧",@"动画",@"音乐",@"舞蹈",@"游戏",@"科技",@"生活",@"科技",@"生活",@"鬼畜",@"时尚",@"广告",@"娱乐",@"电影",@"电视剧"]];
        _selectedIndex = [[NSMutableArray alloc] initWithCapacity:_itemArrArr.count];
        for (int i = 0; i < _itemArrArr.count; i++) {
            [_selectedIndex addObject:@0];
        }
        
        [self loadSubViews];
    }
    return self;
}

#pragma Actions
-(void)btnAction:(UIButton*)btn{
    if (SelectedTag&&SelectedTag == btn.tag){ //隐藏
        [self hideAction];return;
    }
   
    //筛选开关按钮
    UIButton* botton;
    if(SelectedTag){
        botton = (UIButton*)[self viewWithTag:SelectedTag];
        [botton setTitle:[_itemArrArr[SelectedTag-100][[_selectedIndex[SelectedTag-100] integerValue]] stringByAppendingString:@"∨"] forState:UIControlStateNormal];
        if ([_selectedIndex[SelectedTag-100] integerValue]==0) {
           [botton setTintColor:ColorWhite(150)];
        }
    }
    SelectedTag = btn.tag;
    botton = (UIButton*)[self viewWithTag:SelectedTag];
    [botton setTitle:[_itemArrArr[SelectedTag-100][[_selectedIndex[SelectedTag-100] integerValue]] stringByAppendingString:@"∧"] forState:UIControlStateNormal];
    [botton setTintColor:CRed];
    
    
    //筛选按钮
    for(UIView *view in [_selectionView subviews])[view removeFromSuperview];//移除以前的按钮
    //添加筛选选项按钮
    NSArray<NSString *>* itemArr = _itemArrArr[SelectedTag - 100];
    for (int i = 0; i < itemArr.count; i++) {
        UIButton* btn = [[UIButton alloc] init];
        btn.tag = 200+i;
        btn.layer.cornerRadius = 5.0;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:itemArr[i]  forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectionView addSubview:btn];
        
        if([_selectedIndex[SelectedTag -100] integerValue] == i){
            [btn setTitleColor:ColorWhite(255) forState:UIControlStateNormal];
            btn.backgroundColor = CRed;
        }else{
            [btn setTitleColor:ColorWhite(150) forState:UIControlStateNormal];
        }
        
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i%5*_selectionView.width*0.2 + _selectionView.width*0.005);
            make.width.equalTo(_selectionView.mas_width).multipliedBy(0.2 - 0.01);
            make.top.mas_equalTo(i/5*35 + 5);
            make.height.mas_equalTo(35 - 10);
        }];
    }
    
    
    //layout
    [UIView animateWithDuration:0.5 animations:^{
        [_selectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@(ceil(_itemArrArr[SelectedTag-100].count/5.0)*35));
        }];
        [_selectionView layoutIfNeeded];
    }];
    
    [_backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo([self superview].mas_bottom);
    }];
    

}

//筛选选项按钮
-(void)itemAction:(UIButton*)btn{

    UIButton* button = [_selectionView viewWithTag:[_selectedIndex[SelectedTag -100] integerValue]+200];
    [button setTitleColor:ColorWhite(150) forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:ColorWhite(255) forState:UIControlStateNormal];
    btn.backgroundColor = CRed;
    
    _selectedIndex[SelectedTag?SelectedTag-100:0]  = @(btn.tag-200);
    
    [self hideAction];
    if (_delegate)  [_delegate selectedIndexDidChange];
    
}




//隐藏筛选界面
-(void)hideAction{
    //恢复筛选开关按钮
    UIButton* btn = (UIButton*)[self viewWithTag:SelectedTag];
    [btn setTitle:[_itemArrArr[SelectedTag-100][0] stringByAppendingString:@"∨"] forState:UIControlStateNormal];
    if ([_selectedIndex[SelectedTag?SelectedTag-100:0] integerValue]==0) {
        [btn setTintColor:ColorWhite(150)];
    }
    //设置文字
    for (int i = 0; i < _itemArrArr.count; i++) {
        btn = _titleBtnArr[i];
        [btn setTitle:[_itemArrArr[i][[_selectedIndex[i] integerValue]] stringByAppendingString:@"∨"] forState:UIControlStateNormal];
    }
    
    SelectedTag = 0;
    

     //layout
    for(UIView *view in [_selectionView subviews])[view removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        [_selectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@0);
        }];
        [self layoutIfNeeded];
    }];

    [_backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@0);
    }];
}
#pragma loadSubViews

-(void)loadSubViews{
    _titleView = ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorWhite(243);
        [self addSubview:view];
        view;
    });
    
    _titleBtnArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _itemArrArr.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = 100+i;
        [btn setTintColor:ColorWhite(150)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[_itemArrArr[i][0] stringByAppendingString:@"∨"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(_titleView);
            }else{
                if(i == _itemArrArr.count-1){
                    make.right.equalTo(_titleView);
                }
                make.left.equalTo([_titleBtnArr lastObject].mas_right);
                make.width.equalTo([_titleBtnArr firstObject]);
            }
            make.top.bottom.equalTo(_titleView);
        }];
        [_titleBtnArr addObject:btn];
    }
    
    _backgroundView = ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorWhiteAlpha(0, 0.2);
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
        [view addGestureRecognizer:tapGesture];
        [self addSubview:view];
        view;
    });
    
    _selectionView =  ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = ColorWhite(233);
        [self addSubview:view];
        view;
    });
    
    //layout
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@0);
    }];

    [_selectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@0);
    }];
}
@end
