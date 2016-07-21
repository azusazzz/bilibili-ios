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
#import "VideoURLProtocol.h"
#import "VideoURLProtocol.h"

@interface VideoModel ()
<NSURLSessionTaskDelegate, UIWebViewDelegate>

{
    NSURLSession *_session;
    void (^_getVideoURLMode1_CompletionBlock)(NSURL *videoURL);
    void (^_getVideoURLMode2_CompletionBlock)(NSURL *videoURL);
    UIWebView *_webView;
    
    NSInteger _aid;
    
}

@end

@implementation VideoModel

- (instancetype)initWithAid:(NSInteger)aid {
    if (self = [super init]) {
        _aid = aid;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)getVideoInfoWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    [[VideoRequest requestWithAid:_aid] startWithCompletionBlock:^(BaseRequest *request) {
        
        if (request.responseCode == 0 && request.responseData) {
            _videoInfo = [VideoInfoEntity mj_objectWithKeyValues:request.responseData];
            
//            NSMutableArray<NSArray *> *introDataSource = [NSMutableArray arrayWithCapacity:3 + _videoInfo.relates.count];
//            
//            VideoAndStatInfoCellEntity *videoAndStatEntity = [[VideoAndStatInfoCellEntity alloc] init];
//            videoAndStatEntity.title = _videoInfo.title;
//            videoAndStatEntity.view = _videoInfo.stat.view;
//            videoAndStatEntity.danmaku = _videoInfo.stat.danmaku;
//            videoAndStatEntity.desc = _videoInfo.desc;
//            videoAndStatEntity.favorite = _videoInfo.stat.favorite;
//            videoAndStatEntity.coin = _videoInfo.stat.coin;
//            videoAndStatEntity.share = _videoInfo.stat.share;
//            [introDataSource addObject:@[videoAndStatEntity]];
//            
//            VideoOwnerInfoCellEntity *ownerEntity = [[VideoOwnerInfoCellEntity alloc] init];
//            ownerEntity.face = _videoInfo.owner.face;
//            ownerEntity.name = _videoInfo.owner.name;
//            ownerEntity.pubdate = _videoInfo.pubdate;
//            [introDataSource addObject:@[ownerEntity]];
//            
//            _introDataSource = [introDataSource copy];
            
            success();
        }
        else {
            failure(request.errorMsg);
        }
        
    }];
    
}


- (void)getVideoCommentWithSuccess:(void (^)(void))success failure:(void (^)(NSString *))failure {
    
    [[VideoCommentRequest requestWithAid:_aid] startWithCompletionBlock:^(__kindof Request *request) {
        
        if (request.responseObject) {
            _comment = [VideoCommentEntity mj_objectWithKeyValues:request.responseObject];
            success();
        }
        else {
            failure(@"Error");
        }
        
    }];
    
}


- (void)getVideoURLWithCid:(NSInteger)cid completionBlock:(void (^)(NSURL *videoURL))completionBlock {
    
    [self getVideoURLMode1WithCid:cid completionBlock:^(NSURL *videoURL) {
        if (videoURL) {
            completionBlock(videoURL);
        }
        else {
            __block NSInteger page;
            [_videoInfo.pages enumerateObjectsUsingBlock:^(VideoPageInfoEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.cid == cid) {
                    page = obj.page;
                }
            }];
            [self getVideoURLMode2WithPage:page completionBlock:^(NSURL *videoURL) {
                completionBlock(videoURL);
            }];
        }
    }];
    
}


/**
 *  方法1
 *
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getVideoURLMode1WithCid:(NSInteger)cid completionBlock:(void (^)(NSURL *videoURL))completionBlock {
    
    
    completionBlock(NULL);
    
    
    _getVideoURLMode1_CompletionBlock = completionBlock;

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bilibilijj.com/Files/DownLoad/%ld.mp4/www.bilibilijj.com.mp4?mp3=true", cid]];
    
    __weak typeof(self) weakself = self;
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:weakself delegateQueue:[NSOperationQueue mainQueue]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *downloadTask;
    downloadTask = [_session dataTaskWithRequest:request];
    [downloadTask resume];
}

/**
 *  方法2
 *
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getVideoURLMode2WithPage:(NSInteger)page completionBlock:(void (^)(NSURL *videoURL))completionBlock {
    _getVideoURLMode2_CompletionBlock = completionBlock;
    [NSURLProtocol registerClass:[VideoURLProtocol class]];
    
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself webViewVideoURL:NULL];
    });
    [weakself webViewVideoURL:NULL];
    _webView = [[UIWebView alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"http://www.bilibili.com/mobile/video/av%ld.html#page=%ld", _videoInfo.aid, page];
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
}

- (void)webViewVideoURL:(NSURL *)videoURL {
    
    _webView = NULL;
    if (!videoURL) {
        _getVideoURLMode2_CompletionBlock = NULL;
        return;
    }
    _getVideoURLMode2_CompletionBlock ? _getVideoURLMode2_CompletionBlock(videoURL) : NULL;
    _getVideoURLMode2_CompletionBlock = NULL;
}


#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    _getVideoURLMode1_CompletionBlock ? _getVideoURLMode1_CompletionBlock(response.URL) : NULL;
    _getVideoURLMode1_CompletionBlock = NULL;
    [task cancel];
    [_session finishTasksAndInvalidate];
    _session = NULL;
    
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    _getVideoURLMode1_CompletionBlock ? _getVideoURLMode1_CompletionBlock(NULL) : NULL;
    _getVideoURLMode1_CompletionBlock = NULL;
    [dataTask cancel];
    [_session finishTasksAndInvalidate];
    _session = NULL;
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *js = @"\
    function fireClick(node){ \
        if (document.createEvent) { \
            var evt = document.createEvent('MouseEvents'); \
            evt.initEvent('click', true, false); \
            node.dispatchEvent(evt); \
        } \
        else if(document.createEventObject) { \
            node.fireEvent('onclick') ; \
        } \
        else if (typeof node.onclick == 'function') { \
            node.onclick(); \
        } \
    } \
    var theNode = document.getElementsByClassName('player-icon')[0]; \
    setTimeout( \
    'fireClick(theNode)' \
    ,100)";
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    
}


//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//   didSendBodyData:(int64_t)bytesSent
//    totalBytesSent:(int64_t)totalBytesSent
//totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
//    
//    
//    
//}
//
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
//    didReceiveData:(NSData *)data {
//    
//}
//
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didCompleteWithError:(nullable NSError *)error {
//    
//}

@end
