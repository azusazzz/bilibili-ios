//
//  VideoIntroView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoInfoEntity.h"
#import "VideoIntroHeaderView.h"

/**
 *  简介
 */
@interface VideoIntroView : UICollectionView

@property (weak, nonatomic) id<UIScrollViewDelegate> scrollViewDelegate;

@property (strong, nonatomic) VideoInfoEntity *videoInfo;

@property (strong, nonatomic) VideoIntroHeaderView *headerView;


@property (strong, nonatomic) void (^onClickRelate)(NSInteger idx);

@end
