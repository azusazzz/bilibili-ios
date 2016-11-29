//
//  FindMoreReusbleView.m
//  bilibili fake
//
//  Created by C on 16/9/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindMoreReusbleView.h"
#import "Macro.h"
#import <Masonry.h>

@implementation FindMoreReusbleView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _moreBtn = ({
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.tintColor = CRed;
            [self addSubview:btn];
            btn;
        });

       
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_moreLine"]];
        [_moreBtn addSubview:imageView];

        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.with.equalTo(_moreBtn);
            make.height.equalTo(@1.5);
        }];
    }
    return self;
}
@end
