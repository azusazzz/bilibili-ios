//
//  TopicCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "TopicCell.h"
#import "Macro.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@implementation TopicCell{
    UIImageView* coverImageView;
    UILabel* titleLabel;
}
+(CGFloat)height{
    return SSize.width*0.30 + 40;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = ColorWhite(255);
        self.layer.masksToBounds = YES;
        
        coverImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            view.layer.masksToBounds = YES;
            [self addSubview:view];
            view;
        });
        
        titleLabel = ({
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = ColorWhite(0);
            [self addSubview:label];
            label;
        });
        
        //layout
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self).offset(-40);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self.mas_width).offset(-20);
            make.bottom.equalTo(self);
            make.height.equalTo(@40);
        }];
    }
    return self;
}

-(void)setEntity:(TopicEntity *)entity{
    _entity = entity;
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.cover]];
    titleLabel.text = entity.title;
}

@end
