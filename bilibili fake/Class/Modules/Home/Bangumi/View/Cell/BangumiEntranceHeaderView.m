//
//  BangumiEntranceHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEntranceHeaderView.h"
#import "BannerView.h"

@interface BangumiEntranceHeaderView ()
{
    BannerView *_bannerView;
}
@end

@implementation BangumiEntranceHeaderView

+ (CGFloat)heightForBanner:(NSArray<BangumiBannerEntity *> *)banner width:(CGFloat)width {
    if ([banner count] == 0) {
        return 0;
    }
    return width / 960 * 280;
}

- (void)setBanners:(NSArray<BangumiBannerEntity *> *)banners {
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:banners.count];
    for (BangumiBannerEntity *item in banners) {
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


@end
