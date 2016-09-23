//
//  UBangumiCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/23.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UBangumiCell.h"
#import <UIImageView+WebCache.h>

@implementation UBangumiCell{
    UIImageView* coverImageView;
    UILabel* titleLabel;
    UILabel* newest_ep_indexLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0;
        
        coverImageView = ({
            UIImageView* view = [[UIImageView alloc] init];
            [self addSubview:view];
            view;
        });
        //本来是个渐变的懒得画了
        UIView* blankView = ({
            UIView* view = [[UIView alloc] init];
            view.backgroundColor = ColorWhiteAlpha(0, 0.2);
            [self addSubview:view];
            view;
        });
        
        titleLabel = ({
            UILabel* label = [UILabel new];
            label.textColor = ColorWhite(255);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            [self addSubview:label];
            label;
        });
        
        newest_ep_indexLabel = ({
            UILabel* label = [UILabel new];
            label.textColor = ColorWhite(255);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            [self addSubview:label];
            label;
        });
        
        //layout
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(blankView);
            make.height.equalTo(@20);
        }];
        
        [newest_ep_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(titleLabel.mas_bottom).offset(0);
            make.height.equalTo(@15);
        }];
    }
    return self;
}


-(void)setEntity:(UBangumiEntity *)entity{
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.cover]];
    titleLabel.text = entity.title;
    if (entity.is_finish == 0) {
        newest_ep_indexLabel.text = [NSString stringWithFormat:@"更新至 %lu话",entity.newest_ep_index];
    }else{
        newest_ep_indexLabel.text = [NSString stringWithFormat:@"%lu话全",entity.newest_ep_index];
    }
    
}
@end
