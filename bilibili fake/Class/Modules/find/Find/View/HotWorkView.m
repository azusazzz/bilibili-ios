//
//  HotWorkView.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HotWorkView.h"

@implementation HotWorkView
-(instancetype)init{
    self = [super init];
    if (self) {
        _isOpen = NO;
        
        _label = ({
            UILabel* label = [[UILabel alloc] init];
            [self addSubview:label];
            label.text = @"大家都在搜";
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
        
        _hotWorkListView = ({
            JCTagListView* listView = JCTagListView.new;
            [self addSubview:listView];
            listView.tagCornerRadius = 5.0f;
            listView;
        });
        
        _openSwitchBtn = ({
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitle:@" 查看更多" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"search_openMore"] forState:UIControlStateNormal];
            [self addSubview:btn];
            btn;
        });
        
        UIImageView* _openSwitchBgimageView = ({
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_moreLine"]];
            [_openSwitchBtn addSubview:imageView];
            imageView;
        });
        
        //layout
        [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@10);
        }];
        
        [_hotWorkListView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_label.mas_bottom).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(-0);
            make.height.equalTo(@80);
        }];
        
        [_openSwitchBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_hotWorkListView.mas_bottom).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@40);
        }];
        
        [_openSwitchBgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.with.equalTo(_openSwitchBtn);
        }];
    }
    return self;
}

-(void)updateColor{
    _label.textColor =  UIStylePromptLabelColor;
    [_openSwitchBtn setTitleColor:UIStylePromptLabelColor forState:UIControlStateNormal];
    _openSwitchBtn.tintColor = UIStylePromptLabelColor;
    _hotWorkListView.tagTextColor = UIStyleForegroundColor;
    _hotWorkListView.tagBackgroundColor = UIStyleJCTagCellBg;
    
    [_hotWorkListView.collectionView reloadData];
    
}

-(void)setIsOpen:(BOOL)isOpen{
    if (isOpen) {
        [_openSwitchBtn setTitle:@" 收起" forState:UIControlStateNormal];
        [_openSwitchBtn setImage:[UIImage imageNamed:@"search_closeMore"] forState:UIControlStateNormal];
        [_hotWorkListView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_label.mas_bottom).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(-0);
            make.height.equalTo(@200);
        }];
    }else{
        [_openSwitchBtn setTitle:@" 查看更多" forState:UIControlStateNormal];
        [_openSwitchBtn setImage:[UIImage imageNamed:@"search_openMore"] forState:UIControlStateNormal];
        [_hotWorkListView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_label.mas_bottom).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(-0);
            make.height.equalTo(@80);
        }];
    }
    _isOpen = isOpen;
}
@end
