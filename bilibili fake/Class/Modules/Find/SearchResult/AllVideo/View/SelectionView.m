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
        _itemArrs = @[@[@"123",@"asdf",@"123412",@"124412",@"123414",@"12341",@"asdf",@"123412",@"124412",@"123414",@"12341",@"asdf",@"123412",@"124412",@"123414",@"12341",@"asdf",@"123412",@"124412",@"123414",@"12341"],
                      @[@"123",@"asdf",@"123412",@"124412",@"123414",@"12341"],
                      @[@"123",@"asdf",@"123412",@"124412",@"123414"],
                      @[@"123",@"asdf",@"123412",@"124412"],
                      @[@"123",@"asdf",@"123412",@"124412",@"123414",@"12341"]];
        [self loadSubViews];
    }
    return self;
}

#pragma Actions
-(void)btnAction:(UIButton*)btn{
    if (SelectedTag&&SelectedTag == btn.tag)
    {
        //隐藏
        [self hideAction];
    }
    else
    {
        SelectedTag = btn.tag;
        [UIView animateWithDuration:0.5 animations:^{
            [_selectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleView.mas_bottom);
                make.left.right.equalTo(self);
                make.height.equalTo(@(ceil(_itemArrs[SelectedTag-100].count/5.0)*40));
            }];
            [self layoutIfNeeded];
        }];
       
        
        [_backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo([self superview].mas_bottom);
        }];
    }

}


-(void)hideAction{
    SelectedTag = 0;
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
    for (int i = 0; i < _itemArrs.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = 100+i;
        [btn setTintColor:ColorWhite(150)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[_itemArrs[i][0] stringByAppendingString:@"∨"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(_titleView);
            }else{
                if(i == _itemArrs.count-1){
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
