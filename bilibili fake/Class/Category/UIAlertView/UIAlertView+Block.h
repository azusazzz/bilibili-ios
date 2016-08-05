//
//  UIAlertView+Block.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)
<UIAlertViewDelegate>

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles clickedButtonAtIndex:(void (^)(NSInteger buttonIndex))handleClickedButton;

@end
