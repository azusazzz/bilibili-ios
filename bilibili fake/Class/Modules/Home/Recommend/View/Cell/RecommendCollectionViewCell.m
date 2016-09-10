//
//  RecommendCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RecommendCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface ___HomeRecommendGradientView : UIView

@end

@implementation ___HomeRecommendGradientView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:0 green:0.0 blue:0.0 alpha:0.4].CGColor,
                        (__bridge id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0].CGColor];
    const CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), gradient, CGPointMake(0, rect.size.height), CGPointMake(0, 0), 0);
}

@end



@implementation RecommendCollectionViewCell

+ (CGSize)sizeForContentWidth:(CGFloat)width {
    CGFloat itemWidth = (width - 15*3) / 2;
    return CGSizeMake(itemWidth, itemWidth * 0.625 + 5 + 30 + 5);
}

+ (CGFloat)heightForWidth:(CGFloat)width {
    return width * 0.625 + 5 + 30 + 5;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 6;
        _imageView.layer.shouldRasterize = YES;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.right.offset = 0;
            make.top.offset = 0;
            make.height.equalTo(_imageView.mas_width).multipliedBy(0.625);
        }];
    }
    return self;
}

- (void)setBody:(RecommendBodyEntity *)body {
    _body = body;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:body.cover]];
}

- (void)showImageViewBottomGradient {
    if ([self.imageView viewWithTag:10005874]) {
        return;
    }
    ___HomeRecommendGradientView *gradientView = [[___HomeRecommendGradientView alloc] init];
    gradientView.tag = 10005874;
    [self.imageView addSubview:gradientView];
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.height.equalTo(self.imageView.mas_height).multipliedBy(0.4);
    }];
}


@end
