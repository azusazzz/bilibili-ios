//
//  UIView+Frame.h
//  Category
//
//  Created by 翟泉 on 16/5/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置/获取 视图位置、尺寸
 */
@interface UIView (Frame)

#pragma mark point

@property (assign, nonatomic) CGFloat x;

@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat centerX;

@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGFloat maxX;

@property (assign, nonatomic) CGFloat maxY;

@property (assign, nonatomic) CGPoint origin;

#pragma mark size

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize  size;

@end
