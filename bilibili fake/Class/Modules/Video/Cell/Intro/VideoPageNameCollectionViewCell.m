//
//  VideoPageNameCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoPageNameCollectionViewCell.h"

@interface VideoPageNameCollectionViewCell ()
{
    UILabel *_titleLabel;
}
@end

@implementation VideoPageNameCollectionViewCell

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (NSString *)title {
    return _titleLabel.text;
}


- (void)selectItem:(BOOL)select {
    if (select) {
        self.layer.borderColor = CRed.CGColor;
        _titleLabel.textColor = CRed;
    }
    else {
        self.layer.borderColor = ColorWhite(200).CGColor;
        _titleLabel.textColor = ColorWhite(34);
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.contentView.layer.cornerRadius = 4;
        self.contentView.layer.borderColor = ColorWhite(200).CGColor;
        self.contentView.layer.borderWidth = 0.5;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = Font(12);
        _titleLabel.textColor = ColorWhite(34);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.offset = 5;
            make.bottom.offset = -5;
        }];
        
    }
    return self;
}



@end
