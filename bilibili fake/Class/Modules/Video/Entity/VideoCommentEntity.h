//
//  VideoCommentEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoCommentItemEntity.h"

@interface VideoCommentEntity : NSObject

@property (assign, nonatomic) NSInteger results;

@property (assign, nonatomic) NSInteger page;

@property (assign, nonatomic) NSInteger pages;

@property (assign, nonatomic) BOOL isAdmin;

@property (assign, nonatomic) BOOL needCode;

@property (assign, nonatomic) NSInteger owner;

@property (strong, nonatomic) NSArray<VideoCommentItemEntity *> *hotList;

@property (strong, nonatomic) NSArray<VideoCommentItemEntity *> *list;

@property (strong, nonatomic, readonly) NSArray<NSArray<VideoCommentItemEntity *> *> *commentList;




@property (assign, nonatomic) BOOL hasNext;

@property (assign, nonatomic) NSInteger aid;

@end
