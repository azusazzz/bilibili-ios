//
//  VideoTabBar.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoTabBar.h"


@interface VideoTabBar ()
{
    TabBar *_tabBar;
}
@end

@implementation VideoTabBar

//- (instancetype)init {
//    if (self = [super init]) {
//        self.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//}
//
//- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
//    if (self = [super init]) {
//        self.backgroundColor = [UIColor whiteColor];
//        
//        _tabBar = [[TabBar alloc] initWithTitles:titles];
//        [self addSubview:_tabBar];
//        
//        [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.offset = 0;
//            make.bottom.offset = 0;
//            make.width.offset = 160;
//            make.centerX.equalTo(self);
//        }];
//        
//        
//    }
//    return self;
//}
//
//- (void)setContentOffset:(CGFloat)contentOffset {
//    _tabBar.contentOffset = contentOffset;
//}


@end
