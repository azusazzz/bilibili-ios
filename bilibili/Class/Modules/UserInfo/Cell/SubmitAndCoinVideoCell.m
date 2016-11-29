//
//  SubmitVideoCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SubmitAndCoinVideoCell.h"
#import <UIImageView+WebCache.h>

@implementation SubmitAndCoinVideoCell{

    UIImageView* picImageView;
    UILabel* titleLabel;
    UILabel* playLabel;
    UILabel* commentLabel;

}
+(CGSize)size{
    return CGSizeMake((SSize.width-30)/2.0, (SSize.width-30)*0.309 + 40 +12);
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        picImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 5.0;
            [self addSubview:view];
            view;
        });
        
        titleLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.textColor = ColorWhite(50);
            label.font = [UIFont systemFontOfSize:12];
            label.numberOfLines = 2;
            [self addSubview:label];
            label;
        });
        
        UIImageView* playCountImageView = ({
            UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_playCount"]];
            [self addSubview:view];
            view;
        });
        
        playLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.textColor = ColorWhite(150);
            label.font = [UIFont systemFontOfSize:10];
            [self addSubview:label];
            label;
        });
        
        
        UIImageView* danmakuCountImageView = ({
            UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"misc_danmakuCount"]];
            [self addSubview:view];
            view;
        });
        
        commentLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.textColor = ColorWhite(150);
            label.font = [UIFont systemFontOfSize:10];
            [self addSubview:label];
            label;
        });
        
        //layout
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self);
            make.height.equalTo(picImageView.mas_width).multipliedBy(0.618);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picImageView.mas_bottom);
            make.right.left.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        [playCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom);
            make.bottom.left.equalTo(self);
            make.width.equalTo(playCountImageView.mas_height).multipliedBy(1.3);
        }];
        
        [playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom);
            make.left.equalTo(playCountImageView.mas_right).offset(5);
            make.bottom.equalTo(self);
            make.right.equalTo(danmakuCountImageView.mas_left);
        }];
        
        [danmakuCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom);
            make.left.equalTo(self.mas_centerX);
            make.bottom.equalTo(self);
            make.width.equalTo(playCountImageView.mas_height).multipliedBy(1.3);
        }];
        
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom);
            make.left.equalTo(danmakuCountImageView.mas_right).offset(5);
            make.bottom.equalTo(self);
            make.right.equalTo(self);
        }];
    }
    return self;
}

-(void)setSubmitVideoEntity:(SubmitVideoEntity *)submitVideoEntity{
    _submitVideoEntity = submitVideoEntity;
    
    [picImageView sd_setImageWithURL:[NSURL URLWithString:submitVideoEntity.pic]];
    titleLabel.text = submitVideoEntity.title;
    playLabel.text = [NSString stringWithFormat:@"%lu",submitVideoEntity.play];
    commentLabel.text = [NSString stringWithFormat:@"%lu",submitVideoEntity.comment];
}

-(void)setCoinVideoEntity:(CoinVideoEntity *)coinVideoEntity{
    _coinVideoEntity = coinVideoEntity;
    
    [picImageView sd_setImageWithURL:[NSURL URLWithString:coinVideoEntity.pic]];
    titleLabel.text = coinVideoEntity.title;
    playLabel.text = [NSString stringWithFormat:@"%lu",coinVideoEntity.play];
    commentLabel.text = [NSString stringWithFormat:@"%lu",coinVideoEntity.danmaku];
}

@end
