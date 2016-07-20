//
//  VideoIntroHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroHeaderView.h"



@implementation VideoIntroHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _videoAndStatView = [[VideoAndStatInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_videoAndStatView];
        
        _ownerView = [[VideoOwnerInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_ownerView];
        
    }
    return self;
}


- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo {
    
    [_videoAndStatView setupTitle:videoInfo.title viewCount:videoInfo.stat.view danmakuCount:videoInfo.stat.danmaku desc:videoInfo.desc favorite:videoInfo.stat.favorite coin:videoInfo.stat.coin share:videoInfo.stat.share];
    
    [_ownerView setupFace:videoInfo.owner.face name:videoInfo.owner.name pubdate:videoInfo.pubdate];
    
    
    _ownerView.y = _videoAndStatView.maxY;
    
    self.height = _ownerView.maxY;
    
}




@end
