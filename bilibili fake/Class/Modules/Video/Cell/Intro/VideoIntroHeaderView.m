//
//  VideoIntroHeaderView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroHeaderView.h"
#import <ReactiveCocoa.h>


@implementation VideoIntroHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _videoAndStatView = [[VideoAndStatInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_videoAndStatView];
        
        _pagesView = [[VideoPagesView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_pagesView];
        
        _ownerView = [[VideoOwnerInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_ownerView];
        
        _tagsView = [[VideoTagsView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_tagsView];
        
        
        
        __weak typeof(self) weakself = self;
        [RACObserve(_videoAndStatView, frame) subscribeNext:^(id x) {
            CGRect rect = [x CGRectValue];
            CGFloat maxY = rect.origin.y + rect.size.height;
            if (weakself.ownerView.y == maxY) {
                return;
            }
            weakself.pagesView.y = maxY;
            weakself.ownerView.y = weakself.pagesView.maxY;
            weakself.tagsView.y = weakself.ownerView.maxY;
//            weakself.height = weakself.tagsView.maxY;
        }];
        
        [RACObserve(_tagsView, frame) subscribeNext:^(id x) {
            CGRect rect = [x CGRectValue];
            CGFloat maxY = rect.origin.y + rect.size.height;
            if (weakself.ownerView.y == maxY) {
                return;
            }
            weakself.height = weakself.tagsView.maxY;
        }];
        
    }
    return self;
}


- (void)setupVideoInfo:(VideoInfoEntity *)videoInfo {
    
//    _pagesView.pages = videoInfo.pages;
    [_pagesView setupPages:videoInfo.pages];
    [_ownerView setupFace:videoInfo.owner.face name:videoInfo.owner.name pubdate:videoInfo.pubdate];
    [_tagsView setupTags:videoInfo.tags];
    
    [_videoAndStatView setupTitle:videoInfo.title viewCount:videoInfo.stat.view danmakuCount:videoInfo.stat.danmaku desc:videoInfo.desc favorite:videoInfo.stat.favorite coin:videoInfo.stat.coin share:videoInfo.stat.share];
    
    
}




@end
