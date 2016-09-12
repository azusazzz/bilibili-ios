//
//  GameCell.m
//  bilibili fake
//
//  Created by C on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GameCell.h"
#import <UIImageView+WebCache.h>
#import "Macro.h"

@implementation GameCell{
   
    
    UIImageView* coverImageView;
    UILabel* titleLabel;
    UILabel* summaryLabel;
    UIButton* downloadBtn;

}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        coverImageView = ({
            UIImageView* imageView = [UIImageView new];
            [self addSubview:imageView];
            imageView;
        });
        
        titleLabel = ({
            UILabel *title = [UILabel new];
            title.textColor = ColorRGB(0, 0, 0);
            title.font = [UIFont systemFontOfSize:15];
            [self addSubview:title];
            title;
        });
        
        summaryLabel = ({
            UILabel *label  = [UILabel new];
            label.textColor = ColorRGB(150, 150, 150);
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            label;
        });
        
        downloadBtn = ({
            UIButton* btn = [UIButton new];
            [btn setTitle:@"下载" forState:UIControlStateNormal];
            UIColor *color = ColorRGB(253, 129, 164);
            [btn setTitleColor:color forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
            btn.layer.borderColor = color.CGColor;
            [self addSubview:btn];
            btn;
        });
        
//        UIView* separatorView = ({
//            UIView* view = [UIView new];
//            view.backgroundColor = ColorRGB(233, 233, 233);
//            [self addSubview:view];
//            view;
//        });
        

        //layout
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(self);
            make.width.equalTo(coverImageView.mas_height).multipliedBy(2);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverImageView.mas_bottom).offset(5);
            make.left.equalTo(self).offset(25);
            make.height.equalTo(@20);
        }];
        
        [summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(self).offset(25);
            make.height.equalTo(@20);
            make.width.equalTo(titleLabel.mas_width);
        }];
        
        [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverImageView.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.left.equalTo(titleLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        
//        [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self);
//            make.height.equalTo(@10);
//        }];
    }
    return self;
}
- (void)setGameEntity:(GameEntity *)gameEntity{
    _gameEntity = gameEntity;
    titleLabel.text = _gameEntity.title;
    summaryLabel.text = _gameEntity.summary;
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:_gameEntity.cover] placeholderImage:NULL];
}

@end
