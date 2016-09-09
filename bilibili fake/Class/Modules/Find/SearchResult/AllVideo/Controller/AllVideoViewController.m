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
#import "AllVideoTableView.h"

@implementation AllVideoViewController{
    SelectionView* selectionView;
    AllVideoTableView* tableView;
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
    tableView = ({
        AllVideoTableView* view = [[AllVideoTableView alloc] init];
        [self.view addSubview:view];
        view;
    });
    
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
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
}
@end
