//
//  BangumiEpisodesHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BangumiEpisodesHeaderView.h"

@implementation BangumiEpisodesHeaderView
{
    UILabel *titleLabel;
}

+ (NSString *)Identifier {
    return NSStringFromClass([self class]);
}

+ (CGSize)size {
    return CGSizeMake(SSize.width, 30);
}

- (void)setBangumiInfo:(BangumiInfoEntity *)bangumiInfo {
    if (_bangumiInfo == bangumiInfo) {
        return;
    }
    _bangumiInfo = bangumiInfo;
    
    titleLabel.text = [NSString stringWithFormat:@"选集 (%ld)", bangumiInfo.episodes.count];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = Font(15);
        titleLabel.textColor = ColorWhite(34);
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.right.offset = -10;
            make.top.offset = 0;
            make.bottom.offset = 0;
        }];
    }
    return self;
}

@end
