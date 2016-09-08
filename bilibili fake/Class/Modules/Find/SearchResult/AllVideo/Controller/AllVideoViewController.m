//
//  AllVideoViewController.m
//  bilibili fake
//
//  Created by C on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "AllVideoViewController.h"

#import "Macro.h"

#import "SelectionView.h"

@implementation AllVideoViewController{
    SelectionView* selectionView;
    UIView* ChoiceView;
    NSMutableArray<UIButton *>* button;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ChoiceView.frame = CGRectZero;
}
-(void)viewDidLoad{
    [self loadSubViews];
    [self loadActions];
}
-(void)loadActions{
    
}


#pragma loadSubViews
-(void)loadSubViews{
    selectionView = ({
        SelectionView* view = [[SelectionView alloc] init];
        [self.view addSubview:view];
        view;
    });
    //layout
    [selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(selectionView.backgroundView.mas_bottom);
    }];
}
@end
