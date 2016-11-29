//
//  LivePlayer.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/25.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivePlayer : UIViewController

+ (instancetype)playLiveWithURL:(NSURL *)url title:(NSString *)title inController:(UIViewController *)controller;

@end
