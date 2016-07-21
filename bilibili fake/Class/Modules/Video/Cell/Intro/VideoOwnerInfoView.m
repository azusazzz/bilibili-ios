//
//  VideoOwnerInfoView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoOwnerInfoView.h"
#import <UIImageView+WebCache.h>

@interface VideoOwnerInfoView ()
{
    UIImageView *_faceImageView;
    UILabel *_nameLabel;
    UILabel *_pubdateLabel;
}
@end

@implementation VideoOwnerInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        [self initSubviews];
    }
    return self;
}

- (void)setupFace:(NSString *)face name:(NSString *)name pubdate:(NSTimeInterval)pubdate {
    [_faceImageView sd_setImageWithURL:[NSURL URLWithString:face]];
    _nameLabel.text = name;
    
    NSDate *pubDate = [[NSDate alloc] initWithTimeIntervalSince1970:pubdate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    _pubdateLabel.text  = [dateFormatter stringFromDate:pubDate];
    
    self.height = 60;
}

- (void)initSubviews {
    _faceImageView = [[UIImageView alloc] init];
    _faceImageView.layer.masksToBounds = YES;
    _faceImageView.layer.cornerRadius = 20;
    [self addSubview:_faceImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = Font(13);
    [self addSubview:_nameLabel];
    
    _pubdateLabel = [[UILabel alloc] init];
    _pubdateLabel.font = Font(10);
    _pubdateLabel.textColor = ColorWhite(146);
    [self addSubview:_pubdateLabel];
    
    [_faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 40;
        make.height.offset = 40;
        make.centerY.equalTo(self);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_faceImageView.mas_right).offset = 10;
        make.width.offset = 150;
        make.height.offset = 15;
        make.bottom.equalTo(self.mas_centerY).offset = -3;
    }];
    [_pubdateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.width.offset = 150;
        make.height.offset = 12;
        make.top.equalTo(self.mas_centerY).offset = 3;
    }];
    
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = ColorWhite(200);
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
}

@end
