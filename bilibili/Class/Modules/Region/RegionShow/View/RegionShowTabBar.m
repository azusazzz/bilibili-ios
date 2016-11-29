//
//  RegionShowTabBar.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/1.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RegionShowTabBar.h"

@implementation RegionShowTabBar

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    if (self = [super initWithTitles:titles style:TabBarStyleScroll]) {
        self.backgroundColor = CRed;
        self.tintColorRGB = @[@230,@230,@230];
        self.selTintColorRGB = @[@255, @255, @255];
        self.edgeInsets = UIEdgeInsetsMake(0, 10, 4, 10);
        self.spacing = 20;
        
        CGFloat width = 0;
        for (NSString *title in titles) {
            width += [title boundingRectWithSize:CGSizeMake(9999, 16) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(14)} context:NULL].size.width;
        }
        if (width + ([titles count] - 1) * 15 > SSize.width) {
            self.spacing = 15;
        }
        else {
            self.spacing = (SSize.width - 20 - width) / (titles.count - 1);
        }
    }
    return self;
}

@end
