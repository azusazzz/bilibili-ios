//
//  BangumiCell.m
//  bilibili fake
//
//  Created by cxh on 16/7/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "NonVideoCell.h"
#import <Masonry.h>
#import "Macro.h"
#import <UIImageView+WebCache.h>

@implementation NonVideoCell{
    UIImageView* _cover;
    UILabel* _cover_title;
    
    UILabel*  _title;
    UILabel* _total_count;
    UILabel* _play_count;
    UILabel* _brief;
    
    NSMutableDictionary* _data_dic;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSubViews];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    NSString* str = [_data_dic objectForKey:@"type"];
    NSString* url_str = @"";
    if([str isEqualToString:@"bangumi"] ){
        url_str = [_data_dic objectForKey:@"cover"];
    }else if([str isEqualToString:@"upuser"] ){
       url_str = [_data_dic objectForKey:@"upic"];
    }else if([str isEqualToString:@"special"] ){
        url_str = [_data_dic objectForKey:@"pic"];
    }
    [_cover sd_setImageWithURL:[NSURL URLWithString:url_str]];
}


#pragma setData
-(void)setData:(NSMutableDictionary*)data_dic{
    _data_dic = data_dic;
    
}





#pragma loadsubViews
-(void)loadSubViews{
    //封面
     _cover = [UIImageView new];
    [_cover.layer setMasksToBounds:YES];
    [_cover.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    [self addSubview:_cover];
    //封面标签
    _cover_title = [UILabel new];
    _cover_title.backgroundColor = ColorRGB(252, 142, 175);
    _cover_title.textColor = ColorRGB(255, 255, 255);
    _cover_title.text = @"番剧";
    _cover_title.font = [UIFont systemFontOfSize:10];
    [_cover addSubview:_cover_title];
    //标题
    _title = [UILabel new];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textColor = ColorRGB(0, 0, 0);
    [self addSubview:_title];
    
    //视频总数
    _total_count = [UILabel new];
    _total_count.font = [UIFont systemFontOfSize:12];
    _total_count.textColor = ColorRGB(100, 100, 100);
    //_total_count.backgroundColor = [UIColor blueColor];
    [self addSubview:_total_count];
    
    //播放量
    _play_count = [UILabel new];
    _play_count.font = [UIFont systemFontOfSize:12];
    _play_count.textColor = ColorRGB(100, 100, 100);
    [self addSubview:_play_count];
    
    //概要
    _brief = [UILabel new];
    _brief.font = [UIFont systemFontOfSize:12];
    _brief.numberOfLines = 0;
    _brief.textColor = ColorRGB(100, 100, 100);
    [self addSubview:_brief];
    
    // Layout
    //封面
    [_cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(_cover.mas_height);
    }];
    //封面标签
    [_cover_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(_cover);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];
    
    //标题
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.equalTo(@30);
    }];
    //视频总数
    [_total_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.top.equalTo(_title.mas_top).offset(10);
        make.height.equalTo(@15);
    }];
    //播放量
    [_play_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_total_count.mas_centerY);
        make.size.equalTo(_total_count);
        make.left.equalTo(_total_count.mas_right).offset(5);
        make.right.equalTo(self).offset(10);
    }];
    //概要
    [_brief mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(_total_count.mas_bottom).offset(0);
       make.left.equalTo(_cover.mas_left).offset(15);
       make.right.equalTo(self).offset(10);
       make.bottom.equalTo(self.mas_bottom).offset(-7);
    }];
    
}
@end
