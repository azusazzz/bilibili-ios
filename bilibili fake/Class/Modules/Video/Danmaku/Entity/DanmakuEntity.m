//
//  DanmakuEntity.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuEntity.h"

#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DanmakuEntity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _text = [dict objectForKey:@"__text"];
        NSArray *parameters = [[dict objectForKey:@"_p"] componentsSeparatedByString:@","];
        if ([parameters count] != 8) {
            return nil;
        }
        
        
        _time = [parameters[0] doubleValue];
        NSInteger colorHex = [parameters[3] integerValue];
        _color = HexColor(colorHex);
        
        NSInteger type = [parameters[1] integerValue];
        if (type == 1) {
            _type = DanmakuTypeNormal;
        }
        else if (type == 5) {
            _type = DanmakuTypeTop;
        }
        else if (type == 4) {
            _type = DanmakuTypeBottom;
        }
        else {
            return nil;
        }
        
        
        _font = Font(round([parameters[2] integerValue] / 2.0));
        
    }
    return self;
}

@end
