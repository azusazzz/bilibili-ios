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
#import "UILabel+LeftTopAlign.h"
#import <UIImageView+WebCache.h>
#import "UIView+CornerRadius.h"

@implementation VideoCell{
    NSMutableDictionary* _data_dic;//数据主体
    NSString* _order;//筛选条件
    
    UIImageView* _cover;//封面
    UILabel* _ranking;//名次
    
    UILabel*  _title;//标题
    UILabel* _author;//作者
    UILabel* _play_count;//播放量
    
}
-(instancetype)initWithData:(NSMutableDictionary*)dic order:(NSString*)order{
    self = [super init];
    if (self) {
        _data_dic = dic;
        _order = order;
        [self loadSubViews];
        
    }
    //self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return self;
}

- (void)dealloc {
//    LogDEBUG(@"%s", __FUNCTION__);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //设置封面
     NSString* url_str = [_data_dic objectForKey:@"pic"];
    [_cover sd_setImageWithURL:[NSURL URLWithString:url_str]];
    
    //设置排名
    NSString* ranking = [_data_dic objectForKey:@"ranking"];
    if (ranking.length) {
        _ranking.alpha = 0.9;
        _ranking.text = ranking;
        switch ([ranking integerValue]) {
            case 1:_ranking.backgroundColor = ColorRGB(240, 20, 40);break;
            case 2:_ranking.backgroundColor = ColorRGB(240, 120, 10);break;
            case 3:_ranking.backgroundColor = ColorRGB(240, 180, 20);break;
            default:_ranking.backgroundColor = ColorRGB(150, 150, 150);break;
        }
    }else{
        _ranking.alpha = 0;
    }
    [_ranking cornerRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight withCornerRadius:6.0];
    
    //设置标签文字
    NSMutableString *convertedString = [[_data_dic objectForKey:@"title"] mutableCopy];
    _title.text =convertedString;
    [_title textLeftTopAlign];
    _author.text = [NSString stringWithFormat:@"UP主：%@",[_data_dic objectForKey:@"author"]];
    
    //设置排序数量
    NSString* unitCountKey = @"play";
    NSString* unitName = @"播放";
    
    //普通处理
    if ([_order isEqualToString:@"弹幕"]) {
        unitCountKey = @"video_review";
        unitName = @"弹幕";
    } else if([_order isEqualToString:@"评论"]){
        unitCountKey = @"review";
        unitName = @"评论";
    } else if([_order isEqualToString:@"收藏"]){
        unitCountKey = @"favorites";
        unitName = @"收藏";
    }
    
    NSInteger playCount = [[_data_dic objectForKey:unitCountKey] integerValue];
    if(playCount>9999){
        _play_count.text = [NSString stringWithFormat:@"%@：%0.2f万",unitName,playCount/10000.0];
    }else{
        _play_count.text = [NSString stringWithFormat:@"%@：%lu",unitName,playCount];
    }
    //时间
    if([_order isEqualToString:@"日期"]){
        NSString *dateStr = [self getDateStr:[[_data_dic objectForKey:@"senddate"] integerValue]];
         _play_count.text = [NSString stringWithFormat:@"日期：%@",dateStr];
    }
    
  
    
}
#pragma 根据时间计算是长时间以前的
-(NSString*)getDateStr:(NSInteger)date{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now_time=[dat timeIntervalSince1970];
    
    NSInteger difference = now_time - date;
    NSString* str1 = @"";
    NSString* str2 = @"前";
    
    if (difference < 0) {
        str2 = @"以后";
        difference = -difference;
    }
    
    if(difference < 60){
        str1 = [NSString stringWithFormat:@"%lu秒",difference];
    } else if(difference>=60&&difference<3600){
        str1 = [NSString stringWithFormat:@"%lu分",difference/60];
    } else if(difference>=3600&&difference<86400){
        str1 = [NSString stringWithFormat:@"%lu时",difference/3600];
    } else if(difference>=86400&&difference<2592000){
        str1 = [NSString stringWithFormat:@"%lu天",difference/86400];
    } else if(difference>=2592000&&difference<31104000){
        str1 = [NSString stringWithFormat:@"%lu天",difference/86400];
        //str1 = [NSString stringWithFormat:@"%lu月",difference/2592000];
    } else if(difference>=31104000){
        str1 = [NSString stringWithFormat:@"%lu年",difference/31104000];
    }
    
    
    return [str1 stringByAppendingString:str2];
}
#pragma loadsubViews
-(void)loadSubViews{
    //封面
    _cover = [UIImageView new];
    [_cover.layer setMasksToBounds:YES];
    [_cover.layer setCornerRadius:6.0]; //设置矩形四个圆角半径
    [self addSubview:_cover];
    
    //名次
    _ranking = [UILabel new];
    [_ranking.layer setMasksToBounds:YES];
    _ranking.font = [UIFont systemFontOfSize:10];
    _ranking.textAlignment = NSTextAlignmentCenter;
    _ranking.textColor = [UIColor whiteColor];
     [_cover addSubview:_ranking];
   
   
    
    //标题
    _title = [UILabel new];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textColor = ColorRGB(0, 0, 0);
    _title.textAlignment = NSTextAlignmentLeft;
    _title.numberOfLines = 2;

    [self addSubview:_title];
    
    
    //作者
    _author = [UILabel new];
    _author.font = [UIFont systemFontOfSize:12];
    _author.textColor = ColorRGB(100, 100, 100);
    [self addSubview:_author];
    
    //播放量
    _play_count = [UILabel new];
    _play_count.font = [UIFont systemFontOfSize:12];
    _play_count.textColor = ColorRGB(100, 100, 100);
    _play_count.textAlignment = NSTextAlignmentRight;
    [self addSubview:_play_count];
    
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
        make.width.equalTo(_cover.mas_height).multipliedBy(1.5);
    }];
    
    //名次
    [_ranking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(_cover).offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    //标题
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    //作者
    [_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cover.mas_right).offset(15);
        make.top.equalTo(_title.mas_bottom).offset(10);
        make.height.equalTo(@10);
        make.bottom.equalTo(self.mas_bottom).equalTo(@(-10));
    }];
    //播放量
    [_play_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_author.mas_centerY);
        make.size.equalTo(_author);
        make.left.equalTo(_author.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    //分割线
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
        make.height.equalTo(@(0.4));
    }];
}
@end
