//
//  DanmakuModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "DanmakuModel.h"
#import "DanmakuRequest.h"
#import "DanmakuConfiguration.h"

@interface DanmakuModel ()
{
    NSInteger _cid;
    
    NSInteger _index;
    
    NSTimeInterval _lastTime;
}
@end

@implementation DanmakuModel

- (instancetype)initWithCid:(NSInteger)cid {
    self = [super init];
    if (!self) {
        return nil;
    }
    _cid = cid;
    
    
    [[DanmakuRequest requestWithCid:cid] startWithCompletionBlock:^(BaseRequest *request) {
        if (request.responseObject) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                NSArray *array = [request.responseObject objectForKey:@"d"];
                NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:array.count];
                for (NSInteger i=0; i<array.count; i++) {
                    DanmakuEntity *entity = [[DanmakuEntity alloc] initWithDict:array[i]];
                    if (entity) {
                        [mutableArray addObject:entity];
                    }
                }
                [mutableArray sortUsingComparator:^NSComparisonResult(DanmakuEntity* _Nonnull obj1, DanmakuEntity* _Nonnull obj2) {
                    return obj1.time > obj2.time;
                }];
                _danmakuEntitys = [NSArray arrayWithArray:mutableArray];
            });
        }
    }];
    
    
    return self;
}


- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}


- (NSArray<DanmakuEntity *> *)getDisplayDanmakuWithTime:(NSTimeInterval)time {
    if ([_danmakuEntitys count] == 0) {
        return NULL;
    }
    
    
    
    if (fabs(time - _lastTime) > 5) {
        for (NSInteger i=0; i<_danmakuEntitys.count; i++) {
            DanmakuEntity *danmaku = _danmakuEntitys[i];
            if (danmaku.time > time) {
                _index = i;
                break;
            }
        }
        _lastTime = time;
        return @[];
    }
    _lastTime = time;
    
    
    
    NSInteger idx = _index;
    for (NSInteger i=_index; i<_danmakuEntitys.count; i++) {
        DanmakuEntity *danmaku = _danmakuEntitys[i];
        if (danmaku.time > time) {
            idx = i;
            break;
        }
    }
    
    
    NSMutableArray *danmakus = [NSMutableArray arrayWithCapacity:idx-_index];
    for (NSInteger i=_index; i<idx; i++) {
        [danmakus addObject:_danmakuEntitys[i]];
    }
    _index = idx;
    
    if (idx >= _danmakuEntitys.count-1) {
        NSLog(@"结束");
    }
    
    return danmakus;
}

@end
