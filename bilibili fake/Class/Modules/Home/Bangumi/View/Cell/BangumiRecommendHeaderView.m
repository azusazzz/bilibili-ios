//
//  BangumiRecommendHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiRecommendHeaderView.h"

@interface BangumiRecommendHeaderView ()
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
}
@end

@implementation BangumiRecommendHeaderView

+ (CGFloat)height {
    return 35;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"home_bangumi_tableHead_bangumiRecommend"];
        [self addSubview:_iconImageView];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font(14);
        _nameLabel.textColor = ColorWhite(34);
        _nameLabel.text = @"番剧推荐";
        [self addSubview:_nameLabel];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 20;
            make.height.offset = 20;
            make.left.offset = 15;
            make.bottom.offset = 0;
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImageView.mas_right).offset = 5;
            make.width.offset = 80;
            make.height.offset = 20;
            make.bottom.offset = 0;
        }];
        
    }
    return self;
}

@end
