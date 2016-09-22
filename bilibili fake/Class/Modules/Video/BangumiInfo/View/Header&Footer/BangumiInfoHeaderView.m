//
//  BangumiInfoHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiInfoHeaderView.h"
#import <UIImageView+WebCache.h>
#import "ValueConversion.h"

@implementation BangumiInfoHeaderView
{
    SABlurImageView *backgroundView;    // 背景 模糊
    UIImageView     *coverImageView;    // 封面
    UILabel         *titleLabel;        // 标题
    UILabel         *statusLabel;       // 更新状态
    UILabel         *playAndFavoritesCountLabel;    // 播放、订阅
}


+ (NSString *)Identifier {
    return NSStringFromClass([self class]);
}

+ (CGSize)sizeForWidth:(CGFloat)width {
    return CGSizeMake(width, 64 + width * 0.25 * 850.0 / 600.0 + 20);
}
 
- (void)setBangumiInfo:(BangumiInfoEntity *)bangumiInfo {
    if (_bangumiInfo == bangumiInfo) {
        return;
    }
    _bangumiInfo = bangumiInfo;
    
    [backgroundView clearMemory];
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:bangumiInfo.cover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        backgroundView.image = image;
        [backgroundView configrationForBlurAnimation:100];
        [backgroundView blur:0.9];
    }];
    titleLabel.text = bangumiInfo.title;
    if (bangumiInfo.is_finish) {
        statusLabel.text = @"已完结";
    }
    else {
        if (bangumiInfo.weekday > 0) {
            statusLabel.text = [NSString stringWithFormat:@"连载中, 每周%ld更新", bangumiInfo.weekday];
        }
        else {
            statusLabel.text = [NSString stringWithFormat:@"连载中"];
        }
    }
    playAndFavoritesCountLabel.text = [NSString stringWithFormat:@"播放：%@ 订阅：%@", IntegerToTenThousand(bangumiInfo.play_count), IntegerToTenThousand(bangumiInfo.favorites)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        backgroundView = [[SABlurImageView alloc] init];
        backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        backgroundView.clipsToBounds = YES;
        [self addSubview:backgroundView];
        
        coverImageView = [[UIImageView alloc] init];
        coverImageView.layer.cornerRadius = 4;
        coverImageView.layer.masksToBounds = YES;
        coverImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        coverImageView.layer.borderWidth = 1;
        [self addSubview:coverImageView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = Font(15);
        [self addSubview:titleLabel];
        
        statusLabel = [[UILabel alloc] init];
        statusLabel.font = Font(11);
        statusLabel.textColor = [UIColor whiteColor];
        [self addSubview:statusLabel];
        
        playAndFavoritesCountLabel = [[UILabel alloc] init];
        playAndFavoritesCountLabel.font = Font(11);
        playAndFavoritesCountLabel.textColor = [UIColor whiteColor];
        [self addSubview:playAndFavoritesCountLabel];
        
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.bottom.offset = -44;
        }];
        [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 64 + 10;
            make.width.equalTo(self).multipliedBy(0.25);
            make.height.equalTo(coverImageView.mas_width).multipliedBy(850.0 / 600.0);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverImageView.mas_right).offset = 10;
            make.top.equalTo(coverImageView);
            make.right.offset = -10;
            make.height.offset = 18;
        }];
        [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.right.equalTo(titleLabel);
            make.top.equalTo(titleLabel.mas_bottom).offset = 10;
            make.height.offset = 13;
        }];
        [playAndFavoritesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(statusLabel);
            make.right.equalTo(statusLabel);
            make.top.equalTo(statusLabel.mas_bottom).offset = 10;
            make.height.offset = 13;
        }];
    }
    return self;
}

@end
