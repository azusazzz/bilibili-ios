//
//  BangumiLatestUpdateCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiLatestUpdateCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface BangumiLatestUpdateCollectionViewCell ()
{
    UIImageView *_coverView;
    UILabel *_watchingCountLabel;
    UILabel *_titleLabel;
    UILabel *_dateAndIndexLabel;
}
@end

@implementation BangumiLatestUpdateCollectionViewCell

+ (CGFloat)heightForWitdh:(CGFloat)width {
    return width * 0.625 + 5+14+6+15;
}


- (void)setBangumi:(BangumiEntity *)bangumi {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:bangumi.cover]];
    if (bangumi.watchingCount >= 10000) {
        _watchingCountLabel.text = [NSString stringWithFormat:@"%.1lf万人在看", bangumi.watchingCount / 10000.0];
    }
    else {
        _watchingCountLabel.text = [NSString stringWithFormat:@"%ld人在看", bangumi.watchingCount];
    }
    _titleLabel.text = bangumi.title;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)bangumi.last_time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"aHH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    _dateAndIndexLabel.text = [NSString stringWithFormat:@"%@ · 第%ld话", strDate, bangumi.newest_ep_index];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _coverView = [[UIImageView alloc] init];
        _coverView.layer.cornerRadius = 6;
        _coverView.layer.masksToBounds = YES;
        _coverView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_coverView];
        _watchingCountLabel = [[UILabel alloc] init];
        _watchingCountLabel.textColor = ColorWhite(255);
        _watchingCountLabel.backgroundColor = ColorWhite(160);
        _watchingCountLabel.textAlignment = NSTextAlignmentCenter;
        _watchingCountLabel.font = Font(12);
        [self.contentView addSubview:_watchingCountLabel];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textColor = ColorWhite(34);
        [self.contentView addSubview:_titleLabel];
        _dateAndIndexLabel = [[UILabel alloc] init];
        _dateAndIndexLabel.textColor = CRed;
        _dateAndIndexLabel.font = Font(11);
        [self.contentView addSubview:_dateAndIndexLabel];
        
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(_coverView.mas_width).multipliedBy(0.625);
        }];
        [_watchingCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset = 10;
            make.right.offset = 0;
            make.height.offset = 20;
            make.width.offset = 80;
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.equalTo(_coverView.mas_bottom).offset = 5;
            make.height.offset = 14;
        }];
        [_dateAndIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_titleLabel);
            make.top.equalTo(_titleLabel.mas_bottom).offset = 6;
            make.height.offset = 15;
        }];
    }
    return self;
}



@end
