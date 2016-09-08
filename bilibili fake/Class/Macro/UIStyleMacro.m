//
//  UIStyleMacro.m
//  bilibili fake
//
//  Created by cxh on 16/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIStyleMacro.h"
#import "UIColor+String.h"

static UIStyleMacro* UIStyle;

@implementation UIStyleMacro

+(instancetype)share{
    if (UIStyle == NULL) {
        UIStyle = [[UIStyleMacro alloc] init];
    }
    return UIStyle;
}


+(void)changeWithStyleName:(NSString*)styleName{
    if (UIStyle == NULL) {
        UIStyle = [[UIStyleMacro alloc] init];
    }
    [UIStyle changeWithStyleName:styleName];
}
+(void)changeWithIndex:(NSInteger)index{
    if (UIStyle == NULL) {
        UIStyle = [[UIStyleMacro alloc] init];
    }
    [UIStyle changeWithIndex:index];
}




-(instancetype)init{
    self = [super init];
    if (self) {
        NSDictionary* dic1 = @{@"styleName":@"少女粉",
                               @"backgroundColor":[UIColor colorWithRed:253/255.0 green:129/255.0 blue:164/255.0 alpha:1],
                               @"foregroundColor":[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1],
                               @"colourBtnColor": [UIColor colorWithRed:253/255.0 green:255/255.0 blue:255/255.0 alpha:1],
                               @"promptLabelColor":[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1],
                               @"JCTagCellBg":[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1],
                               @"styleNameLabelColor":[UIColor colorWithRed:253/255.0 green:129/255.0 blue:164/255.0 alpha:1],
                               @"SearchResultTabBarColor":@[@255,@255,@255],
                               @"SearchResultTabBarCelTintColor":@[@255,@255,@255]};
        
        NSDictionary* dic2 = @{@"styleName":@"简洁白",
                               @"backgroundColor":[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1],
                               @"foregroundColor":[UIColor colorWithRed:27/255.0 green:27/255.0 blue:27/255.0 alpha:1],
                               @"colourBtnColor":[UIColor colorWithRed:253/255.0 green:129/255.0 blue:164/255.0 alpha:1],
                               @"promptLabelColor":[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1],
                               @"JCTagCellBg":[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1],
                               @"styleNameLabelColor":[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1],
                               @"SearchResultTabBarColor":@[@155,@155,@155],
                               @"SearchResultTabBarCelTintColor":@[@253,@129,@164]};
        
        NSDictionary* dic3 = @{@"styleName":@"帽子绿",
                               @"backgroundColor":[UIColor colorWithRed:43/255.0 green:182/255.0 blue:130/255.0 alpha:1],
                               @"foregroundColor":[UIColor colorWithRed:27/255.0 green:27/255.0 blue:27/255.0 alpha:1],
                               @"colourBtnColor":[UIColor colorWithRed:253/255.0 green:129/255.0 blue:255/255.0 alpha:1],
                               @"promptLabelColor":[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1],
                               @"JCTagCellBg":[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1],
                               @"styleNameLabelColor":[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1],
                               @"SearchResultTabBarColor":@[@155,@155,@155],
                               @"SearchResultTabBarCelTintColor":@[@253,@129,@164]};
        _uiStyleDataArr = @[dic1,dic2,dic3];
        
        //读取本地的
        _styleName = [[[NSUserDefaults alloc] init] stringForKey:@"styleName"];
        
        [self changeWithStyleName:_styleName];
    }
    return self;
}

-(void)changeWithIndex:(NSInteger)index{
     NSDictionary *styleDic = _uiStyleDataArr[index];
    //风格名字
    _styleName = [styleDic objectForKey:@"styleName"];
    //颜色
    _backgroundColor = [styleDic objectForKey:@"backgroundColor"];
    _foregroundColor = [styleDic objectForKey:@"foregroundColor"];
    _colourBtnColor = [styleDic objectForKey:@"colourBtnColor"];
    _promptLabelColor = [styleDic objectForKey:@"promptLabelColor"];
    _JCTagCellBg = [styleDic objectForKey:@"JCTagCellBg"];
    _SearchResultTabBarTintColor = [styleDic objectForKey:@"SearchResultTabBarColor"];
    _SearchResultTabBarCelTintColor = [styleDic objectForKey:@"SearchResultTabBarCelTintColor"];
    [[[NSUserDefaults alloc] init] setObject:_styleName forKey:@"styleName"];
}

-(void)changeWithStyleName:(NSString*)styleName{
    
   __block  NSDictionary *styleDic;
    [_uiStyleDataArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([styleName isEqualToString:[obj objectForKey:@"styleName"]]) {
            styleDic = obj;
        }
    }];
    
    if (styleDic == NULL) {
        styleDic = _uiStyleDataArr[0];
    }
    
    //风格名字
    _styleName = [styleDic objectForKey:@"styleName"];
    //颜色
    _backgroundColor = [styleDic objectForKey:@"backgroundColor"];
    _foregroundColor = [styleDic objectForKey:@"foregroundColor"];
    _colourBtnColor = [styleDic objectForKey:@"colourBtnColor"];
    _promptLabelColor = [styleDic objectForKey:@"promptLabelColor"];
    _JCTagCellBg = [styleDic objectForKey:@"JCTagCellBg"];
    _SearchResultTabBarTintColor = [styleDic objectForKey:@"SearchResultTabBarColor"];
    _SearchResultTabBarCelTintColor = [styleDic objectForKey:@"SearchResultTabBarCelTintColor"];
    [[[NSUserDefaults alloc] init] setObject:_styleName forKey:@"styleName"];
}



@end
