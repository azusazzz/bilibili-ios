//
//  VideoModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/19.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoModel.h"

#import "VideoRequest.h"
#import "VideoCommentRequest.h"

#import <AFNetworking.h>
//#import "VideoURLProtocol.h"
#import "VideoURL.h"

#import "HistoryModel.h" // 历史记录

@interface VideoModel ()
<NSURLSessionTaskDelegate, UIWebViewDelegate>

{
    NSURLSession *_session;
    void (^_getVideoURLMode1_CompletionBlock)(NSURL *videoURL);
    void (^_getVideoURLMode2_CompletionBlock)(NSURL *videoURL);
    UIWebView *_webView;
    
    
    
    
    VideoCommentRequest *_commentRequest;
}



@end

@implementation VideoModel

//- (instancetype)initWithAid:(NSInteger)aid {
//    if (self = [super init]) {
//        _aid = aid;
//    }
//    return self;
//}

- (void)dealloc {
//    Log(@"%s", __FUNCTION__);
}

- (void)getVideoInfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    [[VideoRequest requestWithAid:_aid] startWithCompletionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0 && request.responseData) {
            _videoInfo = [VideoInfoEntity mj_objectWithKeyValues:request.responseData];
            if ([_videoInfo.pages count] == 1) {
                _videoInfo.pages[0].part = _videoInfo.title;
            }
            
            
            success();
            
            /**
             新增历史记录
             */
            HistoryEntity *history = [[HistoryEntity alloc] initWithVideoInfo:_videoInfo];
            [HistoryModel addHistory:history];
            
        }
        else {
            failure(request.errorMsg);
        }
        
    }];
    
}


- (void)getVideoCommentWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    __weak typeof(self) weakself = self;
    
    void (^handler)(__kindof Request *request) = ^(__kindof Request *request) {
        if (request.responseObject) {
            if ([request.responseObject[@"page"] integerValue] == 1) {
                weakself.comment = [VideoCommentEntity mj_objectWithKeyValues:request.responseObject];
            }
            else {
                VideoCommentEntity *comment = [VideoCommentEntity mj_objectWithKeyValues:request.responseObject];
                comment.list = [weakself.comment.list arrayByAddingObjectsFromArray:comment.list];
                weakself.comment = comment;
            }
            weakself.comment.aid = weakself.aid;
            success();
        }
        else {
            failure(@"Error");
        }
    };
    
    
    
    if (!_commentRequest || self.comment.aid != _aid) {
        _commentRequest = [[VideoCommentRequest requestWithAid:_aid] startWithCompletionBlock:^(__kindof Request *request) {
            handler(request);
        }];
    }
    else {
        [_commentRequest nextPageWithCompletionBlock:^(__kindof VideoCommentRequest *request) {
            handler(request);
        }];
    }
    
    
    
}


- (void)getVideoURLWithCid:(NSInteger)cid completionBlock:(void (^)(NSURL *videoURL))completionBlock {
    
    __block NSInteger page;
    [_videoInfo.pages enumerateObjectsUsingBlock:^(VideoPageInfoEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.cid == cid) {
            page = obj.page;
        }
    }];
    
    [VideoURL getVideoURLWithAid:_videoInfo.aid cid:cid page:page completionBlock:completionBlock];
}


@end
