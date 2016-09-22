//
//  UINavigationBar+BackgroundColor.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

/**
 *  背景色
 */
@property (strong, nonatomic) UIColor *backgroundColor;

@property (strong, nonatomic, readonly) UIView *backgroundView;

/**
 *  隐藏底部横线
 */
@property (assign, nonatomic) BOOL hiddenBottomLine;

@property (assign, nonatomic, readonly) UIView *bottomLineView;

@end
