//
//  VideoIntroStatCollectionViewCell.m
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroStatCollectionViewCell.h"

@implementation VideoIntroStatCollectionViewCell

+ (CGFloat)height {
    return 80;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
        downloadButton.backgroundColor = [UIColor whiteColor];
        downloadButton.titleLabel.font = Font(14);
        [downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [downloadButton setTitleColor:CRed forState:UIControlStateNormal];
        downloadButton.layer.cornerRadius = 6;
        downloadButton.layer.borderColor = ColorWhite(200).CGColor;
        downloadButton.layer.borderWidth = 0.5;
        [downloadButton addTarget:self action:@selector(onClickDownload:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downloadButton];
        [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 80;
            make.height.offset = 26;
            make.center.equalTo(self);
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = ColorWhite(200);
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.bottom.offset = 0;
            make.height.offset = 0.5;
        }];
        
    }
    return self;
}

- (void)onClickDownload:(UIButton *)button {
    _onClickDownload ? _onClickDownload() : NULL;
}

@end
