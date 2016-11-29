//
//  SeasonSummaryCell.m
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SeasonSummaryCell.h"
#import "Macro.h"
#import <UIImageView+WebCache.h>

@implementation SeasonSummaryCell{
    UIImageView* coverImageView;//封面
    UILabel* titleLabel;
    UILabel* descLabel;
    UILabel* catDescLabel;
}
+(CGFloat)height{
    return 120;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        coverImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 6.0;
            [self addSubview:view];
            view;
        });
        
        UIImageView* seasonImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.image = [UIImage imageNamed:@"home_region_icon_13"];
            [self addSubview:view];
            view;
        });
        UILabel* 番剧 = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            label.text = @"番剧";
            [self addSubview:label];
            label;
        });
        
        titleLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = ColorWhite(0);
            label.textAlignment = NSTextAlignmentLeft;
            [self addSubview:label];
            label;
        });
        
        descLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            [self addSubview:label];
            label;
        });
        
        catDescLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            [self addSubview:label];
            label;
        });
        
        //layout
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(8);
            make.width.equalTo(coverImageView.mas_height).multipliedBy(0.7);
            make.bottom.equalTo(self).offset(-8);
        }];
        
        [seasonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverImageView);
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        [番剧 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(seasonImageView);
            make.left.equalTo(seasonImageView.mas_right).offset(5);
            make.width.mas_equalTo(@30);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(seasonImageView.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
        }];
        
        [catDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(descLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
        }];
    }
    return self;
}
-(void)setEntity:(SeasonSummaryEntity *)entity{
    _entity = entity;

    [coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.cover]];
    titleLabel.text = entity.title;
    if (entity.finish) {
        descLabel.text = [NSString stringWithFormat:@"%@ 更新至第%@话",entity.newest_season,entity.index];
    }else{
        descLabel.text = [NSString stringWithFormat:@"%@ %@话全",entity.newest_season,entity.index];
    }
    catDescLabel.text = entity.cat_desc;
}
@end
