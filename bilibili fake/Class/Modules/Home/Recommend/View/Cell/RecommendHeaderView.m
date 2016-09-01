//
//  RecommendHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendHeaderView.h"
#import <UIImageView+WebCache.h>
#import "BannerView.h"

@interface RecommendHeaderView ()
{
    BannerView  *_bannerView;
    UIImageView *_leftImageView;
    UILabel     *_leftTitleLabel;
}

@property (strong, nonatomic) NSArray<RecommendBannerEntity *> *banner;

@end

@implementation RecommendHeaderView

+ (CGFloat)heightForRecommend:(RecommendEntity *)recommend width:(CGFloat)width {
    CGFloat height = 20+15;
    if ([recommend.banner_top count]) {
        height += width * 280 / 960;
    }
    return height;
}

- (void)setRecommend:(RecommendEntity *)recommend {
    _banner = recommend.banner_top;
    
    _leftTitleLabel.text = recommend.title;
    _leftImageView.image = [UIImage imageNamed:recommend.logoIconNmae];
    if ([recommend.banner_top count]) {
        [self addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(self.mas_width).multipliedBy(280.0/960.0);
        }];
        NSMutableArray *urls = [NSMutableArray arrayWithCapacity:recommend.banner_top.count];
        for (RecommendBannerEntity *banner in recommend.banner_top) {
            [urls addObject:[NSURL URLWithString:banner.image]];
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
