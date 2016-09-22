//
//  BangumiProfileCollectionViewCell.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiProfileCollectionViewCell.h"

@implementation BangumiProfileCollectionViewCell
{
    UILabel *titleLabel;
    UILabel *profileLabel;
    NSMutableArray<UIButton *> *tagButtons;
}

+ (NSString *)Identifier {
    return NSStringFromClass([self class]);
}

+ (CGSize)sizeForWidth:(CGFloat)width bangumiInfo:(BangumiInfoEntity *)bangumiInfo {
    
    if (bangumiInfo.evaluateHeight == 0) {
        bangumiInfo.evaluateHeight = [bangumiInfo.evaluate boundingRectWithSize:CGSizeMake(width-20, 90) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.height;
    }
    
    if (bangumiInfo.evaluateHeight > Font(12).lineHeight*3) {
        bangumiInfo.evaluateHeight = Font(12).lineHeight*3;
    }
    
    return CGSizeMake(width, 20 + 16 + 10 + bangumiInfo.evaluateHeight + 10);
}

- (void)setBangumiInfo:(BangumiInfoEntity *)bangumiInfo {
    if (_bangumiInfo == bangumiInfo) {
        return;
    }
    _bangumiInfo = bangumiInfo;
    
    profileLabel.text = bangumiInfo.evaluate;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = Font(15);
        titleLabel.textColor = ColorWhite(34);
        titleLabel.text = @"简介";
        [self addSubview:titleLabel];
        
        profileLabel = [[UILabel alloc] init];
        profileLabel.font = Font(12);
        profileLabel.textColor = ColorWhite(86);
        profileLabel.numberOfLines = 3;
        [self addSubview:profileLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.offset = 20;
            make.height.offset = 16;
        }];
        [profileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.equalTo(titleLabel.mas_bottom).offset = 10;
            make.bottom.offset = -10;
        }];
        
    }
    return self;
}

@end
