//
//  VideoModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VideoInfoEntity.h"
#import "VideoCommentEntity.h"

//#import "VideoAndStatInfoCellEntity.h"
//#import "VideoOwnerInfoCellEntity.h"



@interface VideoModel : NSObject

@property (strong, nonatomic) VideoInfoEntity *videoInfo;

@property (strong, nonatomic) VideoCommentEntity *comment;


@property (strong, nonatomic) NSArray *introDataSource;


@property (assign, nonatomic) NSInteger aid;


//- (instancetype)initWithAid:(NSInteger)aid;


/**
 *  获取视频信息
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getVideoInfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


/**
 *  获取评论信息
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getVideoCommentWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


/**
 *  解析出视频链接  
 *
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getVideoURLWithCid:(NSInteger)cid completionBlock:(void (^)(NSURL *videoURL))completionBlock;


//- (void)webViewVideoURL:(NSURL *)videoURL;


@end
