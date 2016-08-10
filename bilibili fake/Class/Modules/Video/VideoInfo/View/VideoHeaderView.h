//
//  VideoHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoInfoEntity.h"
//#import "MediaPlayer.h"
//#import <FXBlurView.h>

@interface VideoHeaderView : UIView

@property (strong, nonatomic) SABlurImageView *backgroundView;

//@property (strong, nonatomic) MediaPlayer *player;

@property (strong, nonatomic) void (^onClickPlay)(void);

- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo;

- (void)playWithURL:(NSURL *)url;

@end
