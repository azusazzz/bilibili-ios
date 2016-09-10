//
//  archiveSummaryEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiveSummaryEntity : NSObject

@property(nonatomic,strong)NSString* param;//Aid

@property(nonatomic,strong)NSString* author;//作者

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@property(nonatomic,strong)NSString* duration;

@property(nonatomic)NSInteger play;//播放量

@property(nonatomic)NSInteger danmaku;//弹幕

@end
/*
 {
 "param" : "4965044",
 "uri" : "bilibili:\/\/video\/4965044",
 "author" : "KBShinya",
 "goto" : "av",
 "title" : "【KBShinya】伪装夫夫 耽美-实力精分【更新至16P】",
 "desc" : "自制 第一次玩耽美游戏……真的是秘制体验………………直播的时候大家吵着要玩这个……更新会在微博及时告诉大家\r\n【2016.8.2】av5619089 游戏同人曲出来了！我自己写的歌词曲子！！！希望大家支持TAT，谢谢很多因为这个实况而认识我的朋友们！感谢你们的陪伴！！！",
 "danmaku" : 183866,
 "cover" : "http:\/\/i0.hdslb.com\/bfs\/archive\/9018f071ffafc98319d19707bd885011ffbe4ad8.jpg",
 "official_verify" : {
 "type" : 0,
 "desc" : ""
 },
 "duration" : "36:30",
 "total_count" : 0,
 "play" : 978550,
 "status" : 0
 }
 */