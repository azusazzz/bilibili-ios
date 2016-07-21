//
//  VideoIntroHeaderView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoInfoEntity.h"

#import "VideoAndStatInfoView.h"
#import "VideoOwnerInfoView.h"
#import "VideoTagsView.h"


@interface VideoIntroHeaderView : UIView

@property (strong, nonatomic) VideoAndStatInfoView *videoAndStatView;

@property (strong, nonatomic) VideoOwnerInfoView *ownerView;

@property (strong, nonatomic) VideoTagsView *tagsView;

- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo;

@end
