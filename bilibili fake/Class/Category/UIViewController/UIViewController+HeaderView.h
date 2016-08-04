//
//  UIViewController+HeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerHeaderView : UIView

@property (strong, nonatomic) NSString *title;

- (void)setBackTarget:(id)target action:(SEL)action;

@end


@interface UIViewController (HeaderView)

@property (strong, nonatomic, readonly) ViewControllerHeaderView *headerView;

@end

