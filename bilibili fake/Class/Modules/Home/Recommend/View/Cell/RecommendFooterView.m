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
    BannerView  *_bannerView;
}

@property (strong, nonatomic) NSArray<RecommendBannerEntity *> *banner;

@end

@implementation RecommendFooterView

+ (CGFloat)heightForBanner:(NSArray<RecommendBannerEntity *> *)banner width:(CGFloat)width {
    return [banner count] > 0 ? width * 280 / 960 : 0;
}

- (void)setBanner:(NSArray<RecommendBannerEntity *> *)banner {
    _banner = banner;
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

- (void)setOnClickBannerItem:(void (^)(RecommendBannerEntity *))onClickBannerItem {
    _onClickBannerItem = onClickBannerItem;
    __weak typeof(self) weakself = self;
    [_bannerView setOnClickBannerItem:^(NSUInteger index) {
        weakself.onClickBannerItem(weakself.banner[index]);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        _bannerView = [[BannerView alloc] init];
        
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = CRed;
//        [self addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_top).offset = -15;
//            make.right.offset = -15;
//            make.width.offset = 60;
//            make.height.offset = 60;
//        }];
        
    }
    return self;
}

@end



