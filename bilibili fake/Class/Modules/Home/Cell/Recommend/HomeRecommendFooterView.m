//
//  HomeRecommendFooterView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeRecommendFooterView.h"
#import <UIImageView+WebCache.h>

@interface HomeRecommendFooterView ()
{
    UIImageView *_bannerView;
}
@end

@implementation HomeRecommendFooterView

+ (CGFloat)heightForBanner:(NSArray<HomeRecommendBannerEntity *> *)banner width:(CGFloat)width {
    return [banner count] > 0 ? width * 280 / 960 : 0;
}

- (void)setBanner:(NSArray<HomeRecommendBannerEntity *> *)banner {
    if ([banner count]) {
        [self addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(self.mas_width).multipliedBy(280.0/960.0);
        }];
        [_bannerView sd_setImageWithURL:[NSURL URLWithString:banner[0].image]];
    }
    else {
        [_bannerView removeFromSuperview];
    }
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _bannerView = [[UIImageView alloc] init];
    }
    return self;
}



@end
