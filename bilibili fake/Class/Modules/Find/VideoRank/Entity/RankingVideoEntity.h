//
//  RankingVideoEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/13.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingVideoEntity : NSObject

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* pic;

@property(nonatomic,strong)NSString* author;//up主

@property(nonatomic)NSInteger aid;

@property(nonatomic)NSInteger play;//播放量

@property(nonatomic)NSInteger ranking;//排名
//@property(nonatomic,strong)NSString* description;//简介
//
//@property(nonatomic,strong)NSString* create;//创建时间
//
//@property(nonatomic,strong)NSString* duration;//时长

@end
/*
 {
 "description" : "皮蛋竟然是熊的蛋蛋？咸鸭蛋看着像怪兽的虫卵？老美这回真的被吓尿了...这期有新面孔哦~",
 "mid" : 6857104,
 "typename" : "搞笑",
 "subtitle" : "",
 "review" : 7,
 "favorites" : 5842,
 "author" : "张逗张花",
 "coins" : 1847,
 "badgepay" : false,
 "pts" : 516288,
 "pic" : "http:\/\/i0.hdslb.com\/bfs\/archive\/5b3f52cbd5d8abaf48a2140e71ab4029c54c3bde.jpg_320x200.jpg",
 "title" : "【老美你怎么看】老美初次遭遇卤蛋、皮蛋、咸鸭蛋和茶叶蛋，彻底被吓呆... 蛋还能长成这样！",
 "video_review" : 9219,
 "duration" : "9:13",
 "create" : "2016-09-09 21:58",
 "aid" : 6216224,
 "play" : 603967
 },
 
 */