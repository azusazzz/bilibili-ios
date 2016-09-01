//
//  RegionShowChildCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/1.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowChildCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation RegionShowChildCollectionViewCell

- (void)setVideo:(RegionShowVideoEntity *)video
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:video.cover]];
    self.titleLabel.text = video.title;
    self.ownerLabel.text = [NSString stringWithFormat:@"UP主: %@", video.name];
    self.viewCountLabel.text = [NSString stringWithFormat:@"播放 :%@", IntegerToTenThousand(video.play)];
    self.danmakuCountLabel.text = [NSString stringWithFormat:@"弹幕 :%@", IntegerToTenThousand(video.danmaku)];
    
    [self.titleLabel layoutIfNeeded];
    CGFloat titleHeight = [self.titleLabel textRectForBounds:CGRectMake(0, 0, self.titleLabel.width, 666) limitedToNumberOfLines:2].size.height;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = titleHeight;
    }];
    
    self.bottomLine.hidden = YES;
    self.backgroundColor = ColorWhite(247);
}

@end
