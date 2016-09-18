//
//  UserInfoLiveEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoLiveEntity : NSObject

@property(nonatomic)NSInteger roomStatus;
@property(nonatomic)NSInteger liveStatus;
@property(nonatomic,strong)NSString* url;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* cover;
@property(nonatomic)NSInteger online;
@property(nonatomic)NSInteger roomid;

@end
/*
{"code":0,"message":"","data":{"roomStatus":0}}//不支持直播
{"code":0,"message":"","data":{"roomStatus":1,"liveStatus":0,"url":"http:\/\/live.bilibili.com\/556368","title":"\u94f6\u96ea\u7693\u6708\u7684\u76f4\u64ad\u95f4","cover":"","online":0,"roomid":556368}}//还没直播
{"code":0,"message":"","data":{"roomStatus":1,"liveStatus":1,"url":"http:\/\/live.bilibili.com\/32421","title":"\u6f2b\u753b\u5bb6\u306e\u5de5\u4f5c\u65e5\u5e38","cover":"http:\/\/i0.hdslb.com\/bfs\/live\/21d79285f27014ed1249e1fb49f26b5768f46560.jpg","online":145,"roomid":32421}}//直播中
 */