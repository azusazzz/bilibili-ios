//
//  LivePartitionsHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "LivePartitionsHeaderView.h"
#import <UIImageView+WebCache.h>
#import "ValueConversion.h"


@interface LivePartitionsHeaderView ()
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    
    UIButton *_moreButton;
    UILabel *_countLabel;
}
@end

@implementation LivePartitionsHeaderView


+ (CGFloat)height {
    return 35;
}

- (void)setPartition:(LiveListPartitionEntity *)partition {
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:partition.icon_src]];
    _nameLabel.text = partition.name;
    _countLabel.text = [NSString stringWithFormat:@"当前%ld个直播，进去看看", partition.count];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_countLabel.attributedText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:CRed range:NSMakeRange(2, IntegerLength(partition.count))];
    _countLabel.attributedText = attributedString;
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = Font(14);
        _nameLabel.textColor = ColorWhite(34);
        [self addSubview:_nameLabel];
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"common_rightArrowShadow"] forState:UIControlStateNormal];
        [self addSubview:_moreButton];
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = Font(14);
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.textColor = ColorWhite(146);
        [self addSubview:_countLabel];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 20;
            make.height.offset = 20;
            make.left.offset = 15;
            make.bottom.offset = 0;
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconImageView.mas_right).offset = 5;
            make.width.offset = 80;
            make.height.offset = 20;
            make.bottom.offset = 0;
        }];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.width.offset = 20;
            make.height.offset = 20;
            make.bottom.offset = 00;
        }];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_moreButton.mas_left).offset = -5;
            make.bottom.offset = 0;
            make.height.offset = 20;
            make.left.equalTo(_nameLabel.mas_right).offset = 10;
        }];
        
    }
    return self;
}

@end
