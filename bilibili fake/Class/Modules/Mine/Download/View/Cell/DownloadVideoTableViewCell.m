//
//  DownloadVideoTableViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DownloadVideoTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation DownloadVideoTableViewCell
{
    UIImageView *picImageView;
    UILabel *titleLabel;
    UILabel *infoLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDownloadVideoEntity:(DownloadVideoEntity *)downloadVideoEntity {
    [picImageView sd_setImageWithURL:[NSURL URLWithString:downloadVideoEntity.pic]];
    titleLabel.text = downloadVideoEntity.title;
    
    if (downloadVideoEntity.status == DownloadOperationStatusSuccess) {
        infoLabel.text = [NSString stringWithFormat:@"已完成 运行中:%lu 已完成:%lu 总下载:%lu", downloadVideoEntity.countRuning, downloadVideoEntity.countSuccess, downloadVideoEntity.pages.count];
    }
    else if (downloadVideoEntity.status == DownloadOperationStatusWaiting) {
        infoLabel.text = [NSString stringWithFormat:@"等待中 运行中:%lu 已完成:%lu 总下载:%lu", downloadVideoEntity.countRuning, downloadVideoEntity.countSuccess, downloadVideoEntity.pages.count];
    }
    else if (downloadVideoEntity.status == DownloadOperationStatusRuning) {
        infoLabel.text = [NSString stringWithFormat:@"缓存中 运行中:%lu 已完成:%lu 总下载:%lu", downloadVideoEntity.countRuning, downloadVideoEntity.countSuccess, downloadVideoEntity.pages.count];
    }
    
    
    [titleLabel layoutIfNeeded];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = [titleLabel textRectForBounds:CGRectMake(0, 0, titleLabel.width, 60) limitedToNumberOfLines:2].size.height;
        make.height.offset = height;
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSMutableArray *rightButtons = [NSMutableArray arrayWithCapacity:4];
        [rightButtons sw_addUtilityButtonWithColor:ColorRGB(253, 85, 98) title:@"删除"];
        [self setRightUtilityButtons:rightButtons];
        
        
        picImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:picImageView];
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = Font(14);
        titleLabel.numberOfLines = 2;
        [self.contentView addSubview:titleLabel];
        infoLabel = [[UILabel alloc] init];
        infoLabel.font = Font(10);
        infoLabel.textColor = ColorWhite(146);
        [self.contentView addSubview:infoLabel];
        
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 10;
            make.bottom.offset = -10;
            make.width.equalTo(picImageView.mas_height).multipliedBy(120.0/80.0);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(picImageView.mas_right).offset = 10;
            make.top.equalTo(picImageView);
            make.right.offset = -10;
            make.height.offset = 16;
        }];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.right.equalTo(titleLabel);
            make.bottom.equalTo(picImageView);
            make.height.offset = 12;
        }];
        
    }
    return self;
}

@end
