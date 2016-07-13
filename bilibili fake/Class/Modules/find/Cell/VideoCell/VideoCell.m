//
//  VideoCell.m
//  bilibili fake
//
//  Created by cxh on 16/7/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoCell.h"
#import <Masonry.h>
#import "Macro.h"
#import <UIImageView+WebCache.h>

@implementation VideoCell{
    NSMutableDictionary* _data_dic;

    
    UIImageView* _cover;//封面
    
    UILabel*  _title;//标题
    UILabel* _author;//作者
    UILabel* _play_count;//播放量
}
-(instancetype)initWithData:(NSMutableDictionary*)dic{
    self = [super init];
    if (self) {
        _data_dic = dic;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //设置封面
     NSString* url_str = [_data_dic objectForKey:@"pic"];
    [_cover sd_setImageWithURL:[NSURL URLWithString:url_str]];

}
#pragma loadsubViews
-(void)loadSubViews{
    //封面
    _cover = [UIImageView new];
    [_cover.layer setMasksToBounds:YES];
    [_cover.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    [self addSubview:_cover];
    
    //标题
    _title = [UILabel new];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textColor = ColorRGB(0, 0, 0);
    _title.numberOfLines = 2;
    [self addSubview:_title];
    
    
    //播放量
    _author = [UILabel new];
    _author.font = [UIFont systemFontOfSize:12];
    _author.textColor = ColorRGB(100, 100, 100);
    [self addSubview:_author];
    
    //播放量
    _play_count = [UILabel new];
    _play_count.font = [UIFont systemFontOfSize:12];
    _play_count.textColor = ColorRGB(100, 100, 100);
    [self addSubview:_play_count];
    
    // Layout
    //封面
    [_cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(_cover.mas_height);
    }];
    
    //标题
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    //作者
    [_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.top.equalTo(_title.mas_bottom).offset(10);
        make.height.equalTo(@15);
        make.bottom.equalTo(self.mas_bottom).equalTo(@(-10));
    }];
    //播放量
    [_play_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_author.mas_centerY);
        make.size.equalTo(_author);
        make.left.equalTo(_author.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}
@end
