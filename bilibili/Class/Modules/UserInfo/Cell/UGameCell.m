//
//  UGameCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UGameCell.h"
#import <UIImageView+WebCache.h>

@implementation UGameCell{
    UIImageView* imageView;
    UILabel* nameLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        imageView = ({
            UIImageView*  view= [UIImageView new];
            [self addSubview:view];
            view;
        });
        
        nameLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = ColorWhite(50);
            [self addSubview:label];
            label;
        });
        
        //label
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(0);
            make.height.equalTo(self).offset(-20);
            make.width.equalTo(imageView.mas_height);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
            make.left.equalTo(imageView.mas_right).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
    }
    return self;
}

-(void)setEntity:(UGameEntity *)entity{
    [imageView sd_setImageWithURL:[NSURL URLWithString:entity.image]];
    nameLabel.text = entity.name;
}


@end
