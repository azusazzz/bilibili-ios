//
//  UIColor+String.m
//  bilibili fake
//
//  Created by cxh on 16/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIColor+String.h"

@implementation UIColor(String)
+(instancetype)colorWithString:(NSString*)string{
    CIColor* ciColor = [CIColor colorWithString:string];
    return [UIColor colorWithRed:ciColor.red green:ciColor.green blue:ciColor.blue alpha:ciColor.alpha];
}

-(NSString*)stringRepresentation{
    return [CIColor colorWithCGColor:self.CGColor].stringRepresentation;
}
@end
