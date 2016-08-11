//
//  MediaPlayer.h
//  IJKMediaPlayer
//
//  Created by cezr on 16/7/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaPlayer : UIViewController

+ (instancetype)playerWithURL:(NSURL *)url cid:(NSInteger)cid title:(NSString *)title inViewController:(UIViewController *)controller;

+ (instancetype)livePlayerWithURL:(NSURL *)url title:(NSString *)title inViewController:(UIViewController *)controller;

@end
