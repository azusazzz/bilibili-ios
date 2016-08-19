//
//  DownloadVideoPageCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoPageCollectionViewCell.h"

@interface DownloadVideoPageCollectionViewCell ()
{
    UILabel *pageLabel;
    UILabel *titleLabel;
    UILabel *leftInfoLabel;
    UILabel *rightInfoLabel;
    UIProgressView *progressView;
    UIButton *statusButton;
}
@end

@implementation DownloadVideoPageCollectionViewCell

+ (CGFloat)height {
    return 70.0;
}

- (void)onClickStatusButton {
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return NULL;
    }
    
    self.backgroundColor = ColorWhite(247);
    
    
    pageLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = Font(12);
        label.textColor = CRed;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        label;
    });
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(14);
    [self.contentView addSubview:titleLabel];
    
    leftInfoLabel = [[UILabel alloc] init];
    leftInfoLabel.font = Font(12);
    leftInfoLabel.textColor = ColorWhite(146);
    [self.contentView addSubview:leftInfoLabel];
    
    rightInfoLabel = [[UILabel alloc] init];
    rightInfoLabel.font = Font(12);
    rightInfoLabel.textColor = ColorWhite(146);
    rightInfoLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:rightInfoLabel];
    
    progressView = [[UIProgressView alloc] init];
    progressView.trackTintColor = [UIColor whiteColor];
    progressView.progressTintColor = ColorWhite(146);
    [self.contentView addSubview:progressView];
    
    statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusButton addTarget:self action:@selector(onClickStatusButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:statusButton];
    
    
    [pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 20;
        make.height.offset = 14;
        make.centerY.offset = 0;
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pageLabel.mas_right).offset = 10;
        make.top.offset = 10;
        make.right.equalTo(statusButton.mas_left).offset = -10;
        
    }];
    
    
    
    return self;
}

@end
