//
//  UPUserSummaryCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UPUserSummaryCell.h"
#import "Macro.h"
#import <UIImageView+WebCache.h>

@implementation UPUserSummaryCell{
    UIImageView* coverImageView;
    UILabel* titleLabel;
    UILabel* fansLabel;
    UILabel* archivesLabel;
    UILabel* signLabel;
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
            view.layer.cornerRadius = 32.0;
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
        
        fansLabel =({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorRGB(100, 100, 100);
            [self addSubview:label];
            label;
        });
        
        archivesLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorRGB(100, 100, 100);
            [self addSubview:label];
            label;
        });
        
        signLabel = ({
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
            make.bottom.equalTo(fansLabel.mas_top).offset(-10);
        }];
        
        [fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.height.equalTo(@15);
            make.bottom.equalTo(signLabel.mas_top).offset(-10);
        }];
        
        [archivesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(fansLabel);
            make.width.equalTo(fansLabel.mas_width);
            make.left.equalTo(fansLabel.mas_right);
            make.right.equalTo(titleLabel);
        }];
        
        [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(titleLabel);
            make.bottom.equalTo(coverImageView);
        }];
    }
    return self;
}
-(void)setEntity:(UPUserSummaryEntity *)entity{
    _entity = entity;
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.cover]];
    titleLabel.text = entity.title;
    fansLabel.text = [NSString stringWithFormat:@"粉丝:%@",[self stringWithNumber:entity.fans]];
    archivesLabel.text = [NSString stringWithFormat:@"视频:%@",[self stringWithNumber:entity.archives]];
    signLabel.text = entity.sign;
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
