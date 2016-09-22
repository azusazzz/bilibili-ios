//
//  BangumiEpisodeCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEpisodeCollectionViewCell.h"

@implementation BangumiEpisodeCollectionViewCell
{
    UILabel *titleLabel;
}

+ (NSString *)Identifier {
    return NSStringFromClass([self class]);
}

- (void)setBangumiEpisode:(BangumiEpisodeEntity *)bangumiEpisode {
    titleLabel.text = [NSString stringWithFormat:@"%ld", bangumiEpisode.index];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = Font(13);
        titleLabel.textColor = ColorWhite(34);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        self.contentView.layer.borderColor = ColorWhite(200).CGColor;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.cornerRadius = 4;
        self.contentView.layer.masksToBounds = YES;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
