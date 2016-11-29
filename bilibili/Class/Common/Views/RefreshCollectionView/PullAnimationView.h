//
//  PullAnimationView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullAnimationView : UIView

@property (assign, nonatomic) CGFloat pullProgress;

- (void)start;

- (void)stop;


@end
