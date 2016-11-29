//
//  LiveListBannerView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LiveListBannerView.h"
#import <UIImageView+WebCache.h>
#import "BannerView.h"
#import <ReactiveCocoa.h>

@interface LiveListBannerView ()
{
//    UIImageView *_imageView;
    
    BannerView *_bannerView;
}
@end

@implementation LiveListBannerView

+ (CGFloat)heightForBanner:(NSArray<LiveListBannerEntity *> *)banner width:(CGFloat)width {
    if ([banner count] == 0) {
        return 0;
    }
    return width / 960 * 280;
}

- (void)setBanner:(NSArray<LiveListBannerEntity *> *)banner {
    _banner = banner;
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:banner.count];
    for (LiveListBannerEntity *item in banner) {
        [urls addObject:[NSURL URLWithString:item.img]];
    }
    _bannerView.urls = urls;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _bannerView = [[BannerView alloc] init];
        [self addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setOnClickBannerItem:(void (^)(LiveListBannerEntity *))onClickBannerItem {
    _onClickBannerItem = onClickBannerItem;
    __weak typeof(self) weakself = self;
    [_bannerView setOnClickBannerItem:^(NSUInteger index) {
        weakself.onClickBannerItem(weakself.banner[index]);
    }];
}

@end
