//
//  RegionShowAvCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/31.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowAvCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation RegionShowAvCollectionViewCell

- (void)setVideo:(RegionShowVideoEntity *)video {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:video.cover]];
    self.titleLabel.text = video.title;
    self.playCountLabel.text = IntegerToTenThousand(video.play);
    self.danmakuCountLabel.text = IntegerToTenThousand(video.danmaku);
    [self.titleLabel layoutIfNeeded];
    CGFloat height = [self.titleLabel textRectForBounds:CGRectMake(0, 0, self.titleLabel.width, 999) limitedToNumberOfLines:2].size.height;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = height;
    }];
}

@end
