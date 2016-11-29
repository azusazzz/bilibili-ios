//
//  UPUserSummaryEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPUserSummaryEntity : NSObject

@property(nonatomic)NSInteger fans;//粉丝

@property(nonatomic)NSInteger archives;//视频投稿数

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@property(nonatomic,strong)NSString* sign;

@property(nonatomic,strong)NSString* uri;

@property(nonatomic,strong)NSString* param;//uid

@end
/*
 {
 "fans" : 368838,
 "archives" : 128,
 "status" : 0,
 "title" : "夏一可",
 "goto" : "author",
 "official_verify" : {
 "type" : 0,
 "desc" : ""
 },
 "param" : "893053",
 "cover" : "http:\/\/i0.hdslb.com\/bfs\/face\/f752483779863578672b75ccf3e1dba0e3b3d3a7.jpg",
 "sign" : "老娘正直勇敢，从不卖萌！微博：夏一可死毒舌 日常（伪）某鱼直播~具体时间会有微博通知！",
 "uri" : "bilibili:\/\/author\/893053",
 "total_count" : 0
 }
 */