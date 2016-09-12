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
#import "UILabel+LeftTopAlign.h"

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
        [self loadSubViews];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    NSString* str = [_data_dic objectForKey:@"type"];
    if([str isEqualToString:@"bangumi"] ){
        [self BangumiSetData];
    }else if([str isEqualToString:@"upuser"] ){
        [self UpuserSetData];
    }else if([str isEqualToString:@"special"] ){
        [self SpecialSetData];
    }
    
}

-(void)BangumiSetData{
    [_cover sd_setImageWithURL:[NSURL URLWithString:[_data_dic objectForKey:@"cover"]]];
    
    _cover_title.text = @"番剧";
    
    _title.text = [_data_dic objectForKey:@"title"];
    
    if ([[_data_dic objectForKey:@"is_finish"] integerValue]) {
        _total_count.text = [NSString stringWithFormat:@"%lu话全",[[_data_dic objectForKey:@"total_count"] integerValue]];
    }else{
        _total_count.text = [NSString stringWithFormat:@"更新至第%lu话",[[_data_dic objectForKey:@"total_count"] integerValue]];
    }
    
    NSInteger playCount = [[_data_dic objectForKey:@"play_count"] integerValue];
    if(playCount>1000){
        _play_count.text = [NSString stringWithFormat:@"播放：%0.1f万",playCount/10000.0];
    }else{
        _play_count.text = [NSString stringWithFormat:@"播放：%lu",playCount];
    }
    
    _brief.text = [_data_dic objectForKey:@"brief"];
    [_brief textLeftTopAlign];
}



-(void)UpuserSetData{
    [_cover sd_setImageWithURL:[NSURL URLWithString:[_data_dic objectForKey:@"upic"]]];
    
    _cover_title.text = @"UP主";
    
    _total_count.text = [NSString stringWithFormat:@"视频: %lu",[[_data_dic objectForKey:@"videos"] integerValue]];

    _title.text = [_data_dic objectForKey:@"uname"];
    
    _play_count.text = @"";
    
    _brief.text = [_data_dic objectForKey:@"usign"];
    [_brief textLeftTopAlign];
}

-(void)SpecialSetData{
    [_cover sd_setImageWithURL:[NSURL URLWithString:[_data_dic objectForKey:@"pic"]]];

    _cover_title.text = @"专题";

    _total_count.text = [NSString stringWithFormat:@"视频: %lu",[[_data_dic objectForKey:@"count"] integerValue]];

    _title.text = [_data_dic objectForKey:@"title"];
    NSInteger playCount = [[_data_dic objectForKey:@"click"] integerValue];
    if(playCount>1000){
        _play_count.text = [NSString stringWithFormat:@"播放：%0.1f万",playCount/10000.0];
    }else{
        _play_count.text = [NSString stringWithFormat:@"播放：%lu",playCount];
    }

    _brief.text = [_data_dic objectForKey:@"description"];
    [_brief textLeftTopAlign];
    
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
    _cover_title.font = [UIFont systemFontOfSize:9];
    _cover_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_cover_title];
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
    
    //分割线
    UIView* separator = [UIView new];
    separator.backgroundColor =  ColorRGB(200, 200, 200);
    [self addSubview:separator];
    
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
        make.size.mas_equalTo(CGSizeMake(25, 12));
    }];
    
    //标题
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.equalTo(@20);
    }];
    //视频总数
    [_total_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.top.equalTo(_title.mas_bottom).offset(5);
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
       make.left.equalTo(_cover.mas_right).offset(15);
       make.right.equalTo(self.mas_right).offset(-10);
       make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    //分割线
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(0.4));
    }];
    
}
@end
