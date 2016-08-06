//
//  RecommendFooterView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendFooterView.h"
#import <UIImageView+WebCache.h>
#import "BannerView.h"

@interface RecommendFooterView ()
{
    BannerView *_bannerView;
}
@end

@implementation RecommendFooterView

+ (CGFloat)heightForBanner:(NSArray<RecommendBannerEntity *> *)banner width:(CGFloat)width {
    return [banner count] > 0 ? width * 280 / 960 : 0;
}

- (void)setBanner:(NSArray<RecommendBannerEntity *> *)banner {
    if ([banner count]) {
        [self addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(self.mas_width).multipliedBy(280.0/960.0);
        }];
        NSMutableArray *urls = [NSMutableArray arrayWithCapacity:banner.count];
        for (RecommendBannerEntity *item in banner) {
            [urls addObject:[NSURL URLWithString:item.image]];
        }
        _bannerView.urls = urls;
    }
    else {
        [_bannerView removeFromSuperview];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        _bannerView = [[BannerView alloc] init];
    }
    return self;
}

@end



