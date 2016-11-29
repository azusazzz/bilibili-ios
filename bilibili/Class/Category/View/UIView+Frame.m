//
//  UIView+Frame.m
//  Category
//
//  Created by 翟泉 on 16/5/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark point

- (CGFloat)x; {
    return self.origin.x;
}

- (void)setX:(CGFloat)x; {
    self.origin = CGPointMake(x, self.y);
}

- (CGFloat)y; {
    return self.origin.y;
}

- (void)setY:(CGFloat)y; {
    self.origin = CGPointMake(self.x, y);
}

- (CGFloat)centerX; {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX; {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY; {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY; {
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)maxX; {
    return self.x + self.width;
}

- (void)setMaxX:(CGFloat)maxX; {
    self.x = maxX - self.width;
}

- (CGFloat)maxY; {
    return self.y + self.height;
}

- (void)setMaxY:(CGFloat)maxY; {
    self.y = maxY - self.height;
}

- (CGPoint)origin; {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin; {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

#pragma mark size

- (CGFloat)width; {
    return self.size.width;
}

- (void)setWidth:(CGFloat)width; {
    self.size = CGSizeMake(width, self.height);
}

- (CGFloat)height; {
    return self.size.height;
}

- (void)setHeight:(CGFloat)height; {
    self.size = CGSizeMake(self.width, height);
}

- (CGSize)size; {
    return self.frame.size;
}

- (void)setSize:(CGSize)size; {
    self.frame = CGRectMake(self.origin.x, self.origin.y, size.width, size.height);
}

@end
