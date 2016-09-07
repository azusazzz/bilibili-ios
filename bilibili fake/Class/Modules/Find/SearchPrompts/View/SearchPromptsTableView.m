//
//  SearchPromptsTableView.m
//  bilibili fake
//
//  Created by cxh on 16/9/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchPromptsTableView.h"
@interface SearchPromptsTableView()<UITableViewDataSource>
@end

@implementation SearchPromptsTableView

-(instancetype)init{
    if (self = [super init]) {
        self.dataSource = self;
        _isHistoryWordArr = YES;
    }
    return self;
}

-(void)setIsHistoryWordArr:(BOOL)isHistoryWordArr{
    _isHistoryWordArr = isHistoryWordArr;
    [self reloadData];
}
-(void)setWordArr:(NSArray<NSString *> *)wordArr{
    _wordArr = wordArr;
    [self reloadData];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isHistoryWordArr&&_wordArr.count) {
        return _wordArr.count+1;
    }
    return _wordArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = ColorRGB(100, 100, 100);
        UIView* line = [UIView new];
        line.backgroundColor = ColorRGB(150, 150, 150);
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(cell);
            make.left.equalTo(cell).offset(15);
            make.height.equalTo(@(0.5));
        }];
    }
    
    if(_isHistoryWordArr){
        if (indexPath.row == _wordArr.count) {
            cell.imageView.image = nil;
            cell.textLabel.text = @"清除搜索历史";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.imageView.image = [UIImage imageNamed:@"search_history_icon"];
            cell.textLabel.text = _wordArr[indexPath.row];
        }
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.imageView.image = nil;
        cell.textLabel.text = _wordArr[indexPath.row];
    }

    return cell;
}



@end
