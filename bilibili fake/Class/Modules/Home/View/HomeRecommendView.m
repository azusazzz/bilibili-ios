//
//  HomeRecommendView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/27.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendView.h"
#import "HomeRecommendModel.h"

#import "HomeRecommendHeaderView.h"
#import "HomeRecommendFooterView.h"
#import "HomeRecommendBodyItemTableViewCell.h"

@interface HomeRecommendView ()
<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) HomeRecommendModel *model;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HomeRecommendView

- (instancetype)init; {
    if (self = [super init]) {
        self.backgroundColor = ColorWhite(247);
        
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = ColorWhite(247);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HomeRecommendBodyItemTableViewCell class] forCellReuseIdentifier:@"Recommend"];
        [_tableView registerClass:[HomeRecommendHeaderView class] forHeaderFooterViewReuseIdentifier:@"Header"];
        [_tableView registerClass:[HomeRecommendFooterView class] forHeaderFooterViewReuseIdentifier:@"Footer"];
        [self addSubview:_tableView];
        
        _model = [[HomeRecommendModel alloc] init];
        [_model getRecommendListWithSuccess:^{
            //
            [_tableView reloadData];
        } failure:^(NSString *errorMsg) {
            //
            HUDFailure(errorMsg);
        }];
        
    }
    return self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_model.recommendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"Recommend"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor grayColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}




@end
