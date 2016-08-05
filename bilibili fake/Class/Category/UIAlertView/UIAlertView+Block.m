//
//  UIAlertView+Block.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@implementation UIAlertView (Block)

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles clickedButtonAtIndex:(void (^)(NSInteger buttonIndex))handleClickedButton {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    
    alertView.title = title;
    alertView.message = message;
    
    for (NSString *buttonTitle in buttonTitles) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    alertView.cancelButtonIndex = 0;
    alertView.delegate = alertView;
    
    objc_setAssociatedObject(alertView, @"handleClickedButton", handleClickedButton, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    void (^handleClickedButton)(NSInteger) = objc_getAssociatedObject(self, @"handleClickedButton");
    
    if (handleClickedButton) {
        handleClickedButton(buttonIndex);
    }
    
}

@end
