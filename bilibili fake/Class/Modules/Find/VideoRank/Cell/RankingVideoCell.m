//
//  RankingVideoCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RankingVideoCell.h"
#import "Macro.h"
#import <UIImageView+WebCache.h>
#import "UIView+CornerRadius.h"

@implementation RankingVideoCell{
    UIImageView* picImageView;//封面
    UILabel* rangkingLabel;
    UILabel* titleLabel;
    UILabel* authorLabel;
    UILabel* playLabel;
    UIView* separatorView;
}

+(CGFloat)height{
    return 80;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        picImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;//圆角设置无效
            view.layer.cornerRadius = 6.0;
            [self addSubview:view];
            view;
        });
        
        rangkingLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = ColorWhite(255);
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 3.0;
            //label.layer.cornerRadius = 6.0;
            //label.textAlignment = NSTextAlignmentCenter;
            [picImageView addSubview:label];
            label;
        });
        
        titleLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = ColorRGB(0, 0, 0);
            label.textAlignment = NSTextAlignmentNatural;
            label.numberOfLines = 2;
            [self addSubview:label];
            label;
        });
        
        authorLabel =({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorRGB(100, 100, 100);
            [self addSubview:label];
            label;
        });
        
        playLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorRGB(100, 100, 100);
            [self addSubview:label];
            label;
        });
        
        separatorView = ({
            UIView* view = [UIView new];
            view.backgroundColor =  ColorRGB(200, 200, 200);
            [self addSubview:view];
            view;
        });
        //layout
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(8);
            make.width.equalTo(picImageView.mas_height).multipliedBy(1.6);
            make.bottom.equalTo(self).offset(-8);
        }];
        
        [rangkingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(picImageView).offset(2);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(picImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(picImageView.mas_top).offset(0);
            make.bottom.equalTo(authorLabel.mas_top).offset(-10);
        }];
        
        [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.height.equalTo(@15);
            make.bottom.equalTo(picImageView);
        }];
        
        [playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(authorLabel);
            make.width.equalTo(@100);
            make.left.equalTo(authorLabel.mas_right);
            make.right.equalTo(titleLabel);
        }];
        
        [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@(0.4));
        }];
        
        [self layoutIfNeeded];
        [rangkingLabel cornerRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight withCornerRadius:6.0];
    }
    return self;
}

-(void)setEntity:(RankingVideoEntity *)entity{
    _entity = entity;
    [picImageView sd_setImageWithURL:[NSURL URLWithString:entity.pic]];
    
    titleLabel.text = [entity.title stringByReplacingOccurrencesOfString:@"【" withString:@"["];
    titleLabel.text = [titleLabel.text stringByReplacingOccurrencesOfString:@"】" withString:@"]"];
    

    rangkingLabel.text = [NSString stringWithFormat:@"  %lu",entity.ranking];
    switch (entity.ranking) {
        case 1:rangkingLabel.backgroundColor = ColorRGBA(240, 20, 40, 0.9);break;
        case 2:rangkingLabel.backgroundColor = ColorRGBA(240, 120, 10, 0.9);break;
        case 3:rangkingLabel.backgroundColor = ColorRGBA(240, 180, 20, 0.9);break;
        default:rangkingLabel.backgroundColor = ColorRGBA(150, 150, 150, 0.9);break;
    }

    
    authorLabel.text = [NSString stringWithFormat:@"UP主:%@",entity.author];
    playLabel.text = [NSString stringWithFormat:@"播放: %@",[self stringWithNumber:entity.play]];
    
}


#pragma 返回数字对应的字符串
-(NSString*)stringWithNumber:(NSInteger)num{
    if(num>9999){
        return [NSString stringWithFormat:@"%0.2f万",num/10000.0];
    }else{
        return [NSString stringWithFormat:@"%lu",num];
    }
}
@end
