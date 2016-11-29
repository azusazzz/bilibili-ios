//
//  MovieSummaryCell.m
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "MovieSummaryCell.h"
#import "Macro.h"
#import <UIImageView+WebCache.h>

@implementation MovieSummaryCell{
    UIImageView* coverImageView;//封面
    UILabel* titleLabel;
    UILabel* screenDataLabel;
    UILabel* areaLabel;
    UILabel* staffLabel;
    UILabel* actorsLabel;
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
        
        UIImageView* movieImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.image = [UIImage imageNamed:@"home_region_icon_23"];
            [self addSubview:view];
            view;
        });
        UILabel* 电影 = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            label.text = @"电影";
            [self addSubview:label];
            label;
        });
        
        titleLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = ColorWhite(0);
            label.textAlignment = NSTextAlignmentLeft;
            [self addSubview:label];
            label;
        });
        
        screenDataLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            [self addSubview:label];
            label;
        });
        
        areaLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            [self addSubview:label];
            label;
        });
        
        staffLabel = ({
            UILabel* label = [UILabel new];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = ColorWhite(100);
            [self addSubview:label];
            label;
        });
        
        actorsLabel = ({
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
        
        [movieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverImageView);
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [电影 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(movieImageView);
            make.left.equalTo(movieImageView.mas_right).offset(5);
            make.width.mas_equalTo(@30);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.top.equalTo(self).offset(30);
            make.height.equalTo(@20);
            make.width.equalTo(@0);
        }];
        
        [screenDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(titleLabel);
            make.left.equalTo(titleLabel.mas_right);
            make.right.equalTo(self.mas_right).offset(-5);
        }];
        
        
        [areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
        }];
        
        [staffLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(areaLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
        }];
        
        [actorsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-5);
            make.top.equalTo(staffLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
        }];
    }
    return self;
}

-(void)setEntity:(MovieSummaryEntity *)entity{
    _entity = entity;
    
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.cover]];
    titleLabel.text = entity.title;
    screenDataLabel.text = [entity.screen_date substringToIndex:4];
    areaLabel.text = entity.area;
    staffLabel.text = entity.staff;
    actorsLabel.text = entity.actors;
    //layout
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(coverImageView.mas_right).offset(10);
        make.top.equalTo(self).offset(30);
        make.height.equalTo(@20);
        make.width.equalTo(@([self getTitleWidth]));
    }];
}

#pragma 计算titleLabel的宽度
-(CGFloat)getTitleWidth{
    //boundingRectWithSize:options:attributes:context
//    CGSize size = [titleLabel.text sizeWithFont:titleLabel.font
//                          constrainedToSize:CGSizeMake(MAXFLOAT, 20)
//                              lineBreakMode:NSLineBreakByWordWrapping];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:titleLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width+10;
}
@end
