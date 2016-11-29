//
//  VideoRankCollectionView.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RefreshCollectionView.h"
#import "VideoRankModel.h"
@interface VideoRankCollectionView : RefreshCollectionView

-(instancetype)initWithTitle:(NSString*)title;

@property(nonatomic,strong,readonly)NSString* title;

@property(nonatomic,strong,readonly)VideoRankModel* model;

@end
