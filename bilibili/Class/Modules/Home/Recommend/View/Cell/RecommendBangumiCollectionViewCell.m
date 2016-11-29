//
//  RecommendBangumiCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendBangumiCollectionViewCell.h"

@interface RecommendBangumiCollectionViewCell ()
{
    UILabel *_titleLabel;
    UILabel *_dateAndIndexLabel;
    
    
}
@end

@implementation RecommendBangumiCollectionViewCell

+ (CGSize)sizeForContentWidth:(CGFloat)width {
    CGFloat itemWidth = (width - 15*3) / 2;
    return CGSizeMake(itemWidth, itemWidth * 0.625 + 30);
}

- (void)setBody:(RecommendBodyEntity *)body {
    if (self.body &&
        [body.title isEqualToString:self.body.title] &&
        [body.cover isEqualToString:self.body.cover] &&
        [body.mtime isEqualToString:self.body.mtime] &&
        body.index == self.body.index) {
        return;
    }
    [super setBody:body];
    
    _titleLabel.text = body.title;
    [_titleLabel layoutIfNeeded];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = [_titleLabel textRectForBounds:CGRectMake(0, 0, _titleLabel.width, 90) limitedToNumberOfLines:2].size.height;
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:GTMzone];
    
    NSDate *date = [dateFormatter dateFromString:[body.mtime componentsSeparatedByString:@"."][0]];
    [dateFormatter setDateFormat:@"aHH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    _dateAndIndexLabel.text = [NSString stringWithFormat:@"%@ · 第%ld话", strDate, body.index];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return NULL;
    }
    
    [self showImageViewBottomGradient];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = Font(12);
    _titleLabel.textColor = ColorWhite(34);
    [self.contentView addSubview:_titleLabel];
    _dateAndIndexLabel = [[UILabel alloc] init];
    _dateAndIndexLabel.textColor = [UIColor whiteColor];
    _dateAndIndexLabel.font = Font(12);
    [self.contentView addSubview:_dateAndIndexLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset = 5;
        make.left.offset = 0;
        make.right.offset = 0;
        make.height.offset = Font(12).lineHeight;
    }];
    [_dateAndIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageView).offset = -5;
        make.left.offset = 5;
        make.right.offset = -5;
        make.height.offset = Font(12).lineHeight;
    }];
    
    return self;
}

@end
