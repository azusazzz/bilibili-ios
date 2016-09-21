//
//  DownloadVideoModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadVideoEntity.h"

@interface DownloadVideoModel : NSObject

@property (strong, nonatomic, readonly) NSArray<DownloadVideoEntity *> *list;

+ (instancetype)sharedInstance;

- (void)downloadVideo:(DownloadVideoEntity *)download;

/**
 *  获取下载视频列表
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getDownlaodVideosWithSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


- (DownloadVideoPageEntity *)hasVideoPageWithAid:(NSInteger)aid cid:(NSInteger)cid;


/**
 *  删除视频
 *
 *  @param aid     <#aid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)deleteVideoWithAid:(NSInteger)aid success:(void (^)(void))success failure:(void (^)(NSString *errorMsg))failure;


@end
