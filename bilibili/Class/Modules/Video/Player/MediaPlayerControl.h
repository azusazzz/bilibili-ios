//
//  MediaPlayerControl.h
//  IJKMediaPlayer
//
//  Created by cezr on 16/7/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IJKMediaPlayback;

@interface MediaPlayerControl : UIControl

@property (strong, nonatomic) NSString *title;

- (instancetype)initWithPlayer:(__weak id<IJKMediaPlayback>)player viewController:(__weak UIViewController *)viewController;

@end
