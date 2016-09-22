//
//  UserInfoHeaderReusableView.m
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoHeaderReusableView.h"

@implementation UserInfoHeaderReusableView{
    UILabel* titleLabel;
    UILabel* countLabe;
    UILabel* seeMoreLabel;
    UIImageView* seeMoreImageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = ColorWhiteAlpha(0, 0.1);
        
        titleLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.textColor = ColorWhite(50);
            label.font = [UIFont systemFontOfSize:14];
            [self addSubview:label];
            label;
        });
        
        countLabe = ({
            UILabel* label = [[UILabel alloc] init];
            label.textColor = ColorWhite(150);
            label.font = [UIFont systemFontOfSize:14];
            [self addSubview:label];
            label;
        });
        
        seeMoreLabel  = ({
            UILabel* label = [[UILabel alloc] init];
            label.textColor = ColorWhite(150);
            label.textAlignment = NSTextAlignmentRight;
            label.text = @"没有公开的数据";//@"进来看看!";
            label.font = [UIFont systemFontOfSize:12];
            [self addSubview:label];
            label;
        });
        
        seeMoreImageView = ({
            UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_rightArrowShadow"]];
            [self addSubview:view];
            view;        
        });
        
        
        //layout
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@60);
        }];
        
        [countLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self);
            make.left.equalTo(titleLabel.mas_right);
            make.width.equalTo(@120);
        }];
        
        [seeMoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
            make.right.equalTo(self).offset(-10);
        }];
        
        [seeMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(self);
            make.right.equalTo(seeMoreImageView.mas_left).offset(-5);
            make.width.equalTo(@100);
        }];
    }
    return  self;
}

-(void)setTitle:(NSString*)title Count:(NSInteger)count{
    titleLabel.text = title;
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([self getLabelWidth:titleLabel]));
    }];
    
    countLabe.text = [NSString stringWithFormat:@"%lu",count];
    if (count) {
        [seeMoreImageView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(@20);
        }];
        seeMoreLabel.text = @"进来看看!";
    }else{
        [seeMoreImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        seeMoreLabel.text = @"没有公开的数据";
    }
}

#pragma 计算titleLabel的宽度
-(CGFloat)getLabelWidth:(UILabel*)label{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width+15;
    
}
@end
