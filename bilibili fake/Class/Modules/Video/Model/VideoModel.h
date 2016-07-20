//
//  VideoModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoInfoEntity.h"

//#import "VideoAndStatInfoCellEntity.h"
//#import "VideoOwnerInfoCellEntity.h"



@interface VideoModel : NSObject

@property (strong, nonatomic) VideoInfoEntity *videoInfo;


@property (strong, nonatomic) NSArray *introDataSource;


/**
 *  获取视频信息
 *
 *  @param aid     <#aid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getVideoInfoWithAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;

/**
 *  解析出视频链接  
 *
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getVideoURLWithCid:(NSInteger)cid completionBlock:(void (^)(NSURL *videoURL))completionBlock;


- (void)webViewVideoURL:(NSURL *)videoURL;


@end
