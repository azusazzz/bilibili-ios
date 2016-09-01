//
//  RegionShowBannerCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/31.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowBannerCollectionViewCell.h"
#import "BannerView.h"

@interface RegionShowBannerCollectionViewCell ()

@property (strong, nonatomic) BannerView *bannerView;

@end

@implementation RegionShowBannerCollectionViewCell

+ (CGSize)sizeForWidth:(CGFloat)width {
    return CGSizeMake(width, width * 280 / 960);
}

- (void)setBanners:(NSArray<RegionShowBannerEntity *> *)banners {
    _banners = banners;
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:banners.count];
    for (RegionShowBannerEntity *banner in banners) {
        [urls addObject:[NSURL URLWithString:banner.image]];
    }
    _bannerView.urls = urls;
}

- (void)setOnClickBannerItem:(void (^)(RegionShowBannerEntity *))onClickBannerItem {
    _onClickBannerItem = onClickBannerItem;
    __weak typeof(self) weakself = self;
    [_bannerView setOnClickBannerItem:^(NSUInteger index) {
        weakself.onClickBannerItem(weakself.banners[index]);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        _bannerView = [[BannerView alloc] init];
        [self addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
//            make.height.equalTo(self.mas_width).multipliedBy(280.0/960.0);
            make.bottom.offset = 0;
        }];
    }
    return self;
}


@end
