//
//  UIView+CornerRadius.h
//  UIViewTest
//
//  Created by Artron_LQQ on 16/2/20.
//  Copyright © 2016年 Artup. All rights reserved.
//


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
