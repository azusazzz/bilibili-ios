//
//  VideoTabBar.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoTabBar.h"


@interface VideoTabBar ()

@end

@implementation VideoTabBar

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    if (self = [super initWithTitles:titles style:TabBarStyleNormal]) {
        self.edgeInsets = UIEdgeInsetsMake(0, (SSize.width-180)/2, 0, (SSize.width-180)/2);
    }
    return self;
}

@end
