//
//  DownloadVideoCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface DownloadVideoCollectionViewCell ()
{
    UIImageView *picImageView;
    UILabel *titleLabel;
    UILabel *infoLabel;
}
@end

@implementation DownloadVideoCollectionViewCell

- (void)setDownloadVideoEntity:(DownloadVideoEntity *)downloadVideoEntity {
    [picImageView sd_setImageWithURL:[NSURL URLWithString:downloadVideoEntity.pic]];
    titleLabel.text = downloadVideoEntity.title;
    infoLabel.text = [NSString stringWithFormat:@"已完成 运行中:0 已完成:0 总下载:%ld", downloadVideoEntity.pages.count];
    
    [titleLabel layoutIfNeeded];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = [titleLabel textRectForBounds:CGRectMake(0, 0, titleLabel.width, 60) limitedToNumberOfLines:2].size.height;
        make.height.offset = height;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return NULL;
    }
    
    picImageView = [[UIImageView alloc] init];
    [self addSubview:picImageView];
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(14);
    titleLabel.numberOfLines = 2;
    [self addSubview:titleLabel];
    infoLabel = [[UILabel alloc] init];
    infoLabel.font = Font(10);
    infoLabel.textColor = ColorWhite(146);
    [self addSubview:infoLabel];
    
    [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.offset = 0;
        make.bottom.offset = 0;
        make.width.equalTo(picImageView.mas_height).multipliedBy(120.0/80.0);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(picImageView.mas_right).offset = 10;
        make.top.offset = 0;
        make.right.offset = -10;
        make.height.offset = 16;
    }];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(titleLabel);
        make.bottom.offset = 0;
        make.height.offset = 12;
    }];
    
    
    return self;
}

@end
