//
//  HomeHeaderView.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()

{
    
}

@end

@implementation HomeHeaderView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    if (self = [super initWithTitles:titles style:TabBarStyleNormal]) {
        self.backgroundColor = CRed;
        self.tintColorRGB = @[@230,@230,@230];
        self.selTintColorRGB = @[@255, @255, @255];
        self.edgeInsets = UIEdgeInsetsMake(0, (SSize.width-50*titles.count)/2, 4, (SSize.width-50*titles.count)/2);
        self.spacing = 20;
    }
    return self;
}

@end
