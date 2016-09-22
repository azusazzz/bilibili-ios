//
//  UINavigationBar+BackgroundColor.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackgroundColor)

- (UIColor *)backgroundColor {
    return self.barTintColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.barTintColor = backgroundColor;
    self.backgroundView.backgroundColor = backgroundColor;
}


- (UIView *)backgroundView {
    UIView *view = objc_getAssociatedObject(self, @selector(backgroundView));
    if (!view) {
        for (UIView *subview in self.subviews) {
            // iOS 9.3.2
            if ([subview isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                view = subview;
                break;
            }
        }
    }
    return view;
}

- (BOOL)hiddenBottomLine {
    return self.bottomLineView.hidden;
}

- (void)setHiddenBottomLine:(BOOL)hiddenBottomLine {
    self.bottomLineView.hidden = hiddenBottomLine;
}

- (UIView *)bottomLineView {
    UIView *view = objc_getAssociatedObject(self, @selector(bottomLineView));
    if (!view) {
        for (UIView *subview in self.subviews) {
            if (subview.height <= 1 && [subview isKindOfClass:[UIImageView class]]) {
                view = subview;
                break;
            }
        }
    }
    return view;
}

@end
