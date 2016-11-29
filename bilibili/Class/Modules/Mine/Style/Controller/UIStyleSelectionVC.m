//
//  UIStyleSelectionVC.m
//  bilibili fake
//
//  Created by cxh on 16/8/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//
#import "UIStyleMacro.h"
#import "UIStyleSelectionVC.h"
#import "UIStyleCell.h"

#import <Masonry.h>
@interface UIStyleSelectionVC()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation UIStyleSelectionVC{
    UITableView* styleTableView;

}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.tintColor = UIStyleForegroundColor;
    self.navigationController.navigationBar.barTintColor = UIStyleBackgroundColor;
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: UIStyleForegroundColor,
      NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};  //标题颜色和字体
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorRGB(245, 245, 245);
    
    [self loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIStyleMacro changeWithIndex:indexPath.row];
    
    [self viewWillAppear:YES];
    [tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [UIStyleMacro share].uiStyleDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UIStyleCell"];
    if (cell == nil) {
        cell = [[UIStyleCell alloc] initWithIndex:indexPath.row];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - Subviews
- (void)loadSubviews {
    self.navigationItem.title = @"设置主题";
    
    styleTableView = [[UITableView alloc] init];
    styleTableView.delegate = self;
    styleTableView.dataSource = self;
    [self.view addSubview:styleTableView];
    
    [styleTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
