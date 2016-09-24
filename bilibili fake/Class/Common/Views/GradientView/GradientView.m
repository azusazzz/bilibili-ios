//
//  GradientView.m
//  bilibili fake
//
//  Created by C on 16/9/24.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
-(void)drawRect:(CGRect)rect{
  
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    NSArray* gradientColors = @[(id)ColorWhiteAlpha(0, 0.0).CGColor,(id)ColorWhiteAlpha(0, 0.5).CGColor];//开始颜色，结束颜色
    CGFloat locations[2] = {0.0,1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, locations);
    CGContextSaveGState(context);
    UIBezierPath* rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [rectPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(self.width*0.5, 0), CGPointMake(self.width*0.5, self.height), 0);
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

@end
