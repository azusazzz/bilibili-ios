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

@implementation SearchPromptsTableView{
    SearchPromptsModel *model;
}

-(instancetype)initWithModel:(SearchPromptsModel*)searchPromptsModel{
    if (self = [super init]) {
        model = searchPromptsModel;
        _wordArr = model.historyWordArr;
        self.dataSource = self;
    }
    return self;
}

-(void)setKeyWord:(NSString *)keyWord{
    _keyWord = keyWord;
    if (_keyWord.length) {
        _wordArr = [[NSMutableArray alloc] init];
        if ([self avID].length)[_wordArr addObject:[self avID]];
        
        [model getPromptsWordArrWithKeyWord:keyWord success:^{
            [_wordArr addObjectsFromArray:model.promptsWordArr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
            });
        } failure:nil];
    }else{
        _wordArr = model.historyWordArr;
    }
    [self reloadData];
}

-(NSString*)avID{
    //判断是否为整形
    NSString* string = _keyWord;
    if (_keyWord.length>2) {
        NSString* str = [_keyWord substringToIndex:2];
        if ([str caseInsensitiveCompare:@"av"]==NSOrderedSame) {
            string = [_keyWord substringFromIndex:2];
        }
    }
    NSInteger val = [string integerValue];
    if(val&&[[NSString stringWithFormat:@"%lu",val] isEqualToString:string]){
        return [NSString stringWithFormat:@"av%lu",val];
    }
    return @"";
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_keyWord.length == 0&&_wordArr.count) {
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
    
    if(_keyWord.length){
        if ([self avID].length&&indexPath.row == 0) {
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
        }
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.imageView.image = nil;
        cell.textLabel.text = _wordArr[indexPath.row];
    }else{
        if (indexPath.row == _wordArr.count) {
            cell.imageView.image = nil;
            cell.textLabel.text = @"清除搜索历史";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.imageView.image = [UIImage imageNamed:@"search_history_icon"];
            cell.textLabel.text = _wordArr[indexPath.row];
        }
    }

    return cell;
}


@end
