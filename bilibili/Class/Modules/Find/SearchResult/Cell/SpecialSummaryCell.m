//
//  SpecialSummaryCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SpecialSummaryCell.h"
#import "Macro.h"
#import <UIImageView+WebCache.h>

@implementation SpecialSummaryCell{
    UIImageView* coverImageView;
    UILabel* titleLabel;
    UILabel* archivesLabel;
    UILabel* playLabel;
    UILabel* descLabel;
}

+(CGFloat)height{
    return 80;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        coverImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 3.0;
            [self addSubview:view];
            view;
        });
        
        titleLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = ColorRGB(0, 0, 0);
            [self addSubview:label];
            label;
        });
        
        archivesLabel =({
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
        
        descLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorRGB(100, 100, 100);
            [self addSubview:label];
            label;
        });
        //layout
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(8);
            make.width.equalTo(coverImageView.mas_height).multipliedBy(1.0);
            make.bottom.equalTo(self).offset(-8);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(coverImageView.mas_top).offset(0);
            make.bottom.equalTo(archivesLabel.mas_top).offset(-10);
        }];
        
        [archivesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.height.equalTo(@15);
            make.bottom.equalTo(descLabel.mas_top).offset(-10);
        }];
        
        [playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(archivesLabel);
            make.width.equalTo(archivesLabel.mas_width);
            make.left.equalTo(archivesLabel.mas_right);
            make.right.equalTo(titleLabel);
        }];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(titleLabel);
            make.bottom.equalTo(coverImageView);
        }];
    }
    return self;
}
-(void)setEntity:(SpecialSummaryEntity *)entity{
    _entity = entity;
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.cover]];
    titleLabel.text = entity.title;
    archivesLabel.text = [NSString stringWithFormat:@"视频:%@",[self stringWithNumber:entity.archives]];
    playLabel.text = [NSString stringWithFormat:@"播放:%@",[self stringWithNumber:entity.play]];
    descLabel.text = entity.desc;
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
