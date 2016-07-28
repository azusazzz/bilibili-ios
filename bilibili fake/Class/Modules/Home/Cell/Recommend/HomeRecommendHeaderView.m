//
//  HomeRecommendHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendHeaderView.h"
#import <UIImageView+WebCache.h>

@interface HomeRecommendHeaderView ()
{
    UIImageView *_bannerView;
    
    UIImageView *_leftImageView;
    UILabel *_leftTitleLabel;
}
@end

@implementation HomeRecommendHeaderView

+ (CGFloat)heightForRecommend:(HomeRecommendEntity *)recommend width:(CGFloat)width {
    CGFloat height = 20+15;
    if ([recommend.banner_top count]) {
        height += width * 280 / 960;
    }
    return height;
}

- (void)setRecommend:(HomeRecommendEntity *)recommend {
    _leftTitleLabel.text = recommend.title;
//    _leftImageView.image = [UIImage imageNamed:@"hd_home_recommend"];
    _leftImageView.image = [UIImage imageNamed:recommend.logoIconNmae];
    if ([recommend.banner_top count]) {
        [self addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(self.mas_width).multipliedBy(280.0/960.0);
        }];
        [_bannerView sd_setImageWithURL:[NSURL URLWithString:recommend.banner_top[0].image]];
    }
    else {
        [_bannerView removeFromSuperview];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _bannerView = [[UIImageView alloc] init];
        
        
        
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.font = Font(14);
        _leftTitleLabel.textColor = ColorWhite(34);
        [self addSubview:_leftTitleLabel];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 15;
            make.bottom.offset = 0;
            make.width.offset = 20;
            make.height.offset = 20;
        }];
        [_leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset = 5;
            make.bottom.offset = 0;
            make.width.offset = 100;
            make.height.offset = 20;
        }];
    }
    return self;
}

@end
