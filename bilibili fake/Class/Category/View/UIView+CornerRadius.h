//
//  UIView+CornerRadius.h
//  UIViewTest
//
//  Created by Artron_LQQ on 16/2/20.
//  Copyright © 2016年 Artup. All rights reserved.
//
/**
 *  @author LQQ, 16-02-20 23:02:40
 *
 *  github地址:https://github.com/LQQZYY/UIViewCornerDemo
 *
 *  喜欢的话就给颗星支持一下,感谢!
 *
 *
 */

#import <UIKit/UIKit.h>


@interface UIView (CornerRadius)



/**
 *
 *  设置不同角的圆角(得Masonry确定尺寸之后才能用)
 *
 *  @param sideType 圆角类型
 *  @param cornerRadius 圆角半径
 */
- (void)cornerRoundingCorners:(UIRectCorner)RoundingCorners withCornerRadius:(CGFloat)cornerRadius;

@end
