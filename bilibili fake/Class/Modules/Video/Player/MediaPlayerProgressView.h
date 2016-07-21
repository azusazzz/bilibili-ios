//
//  MediaPlayerProgressView.h
//  IJKMediaPlayer
//
//  Created by cezr on 16/7/17.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MediaPlayerProgressView : UISlider


@end


@interface MediaChangeProgressMessageView : UIVisualEffectView

+ (MediaChangeProgressMessageView *)showChangeProgressViewWith:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration inView:(UIView *)view;

@end