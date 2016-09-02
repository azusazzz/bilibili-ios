//
//  GameCenterCell.m
//  bilibili fake
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCenterCell.h"
#import <UIImageView+WebCache.h>
#import "Macro.h"
#import <Masonry.h>
#import <ReactiveCocoa.h>
@implementation GameCenterCell{
    NSDictionary* data_Dic;
    
    UIImageView* imageView;
    UILabel* title;
    UILabel* des;
    UIButton* Download_btn;
    UIView* Separator_view;
}

//{"id":34,"title":"ICHU偶像进行曲","summary":"把我变成真正的偶像吧！","download_link":"http://acg.tv/u1fO","cover":"http://i0.hdslb.com/bfs/game/9fa835022acae8250720b8b89b7c5e5a7da59707.jpg","hot":0,"new":0}

-(instancetype)initWithData:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        data_Dic = dic;
        
        
        imageView = [UIImageView new];
        //imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(self);
            make.width.equalTo(imageView.mas_height).multipliedBy(2);
        }];
        
        title = [UILabel new];
        title.text = [dic objectForKey:@"title"];
        title.textColor = ColorRGB(0, 0, 0);
        title.font = [UIFont systemFontOfSize:15];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(5);
            make.left.equalTo(self).offset(25);
            make.height.equalTo(@20);
        }];
        
        des = [UILabel new];
        des.text = [dic objectForKey:@"summary"];
        des.textColor = ColorRGB(150, 150, 150);
        des.font = [UIFont systemFontOfSize:13];
        [self addSubview:des];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(5);
            make.left.equalTo(self).offset(25);
            make.height.equalTo(@20);
            make.width.equalTo(title.mas_width);
        }];
        
        Download_btn = [UIButton new];
        [Download_btn setTitle:@"下载" forState:UIControlStateNormal];
        UIColor *color = UIStyleColourBtnColor;
        [Download_btn setTitleColor:color forState:UIControlStateNormal];
        [Download_btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [Download_btn.layer setMasksToBounds:YES];
        [Download_btn.layer setBorderWidth:1.0];
        [Download_btn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        Download_btn.layer.borderColor = color.CGColor;
        [self addSubview:Download_btn];
        [Download_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.left.equalTo(title.mas_right);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        Download_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"请跳转到:%@",[dic objectForKey:@"download_link"]);
            return [RACSignal empty];
        }];
        
        Separator_view = [UIView new];
        Separator_view.backgroundColor = ColorRGB(243, 243, 243);
        [self addSubview: Separator_view];
        [self addSubview:Separator_view];
        [Separator_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@10);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[data_Dic objectForKey:@"cover"]] placeholderImage:NULL];
    // Configure the view for the selected state
  
}

@end
