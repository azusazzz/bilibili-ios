//
//  UserInfoCoinVideosEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CoinVideoEntity : NSObject

@property(nonatomic,strong)NSString* pic;
@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSDictionary* stat;
@property(nonatomic,readonly)NSInteger danmaku;//弹幕
@property(nonatomic,readonly)NSInteger play;

@property(nonatomic)NSInteger aid;

@end






@interface UserInfoCoinVideosEntity : NSObject

@property(nonatomic)NSInteger count;
@property(nonatomic)NSInteger pages;
@property(nonatomic,strong)NSMutableArray<CoinVideoEntity*>* list;

@end
/*
{
    "status" : true,
    "data" : {
        "pages" : 1,
        "count" : 3,
        "list" : [
                  {
                      "pubdate" : 1474014991,
                      "state" : 0,
                      "attribute" : 540672,
                      "rights" : {
                          "movie" : 0,
                          "elec" : 0,
                          "pay" : 0,
                          "download" : 0,
                          "bp" : 0
                      },
                      "tname" : "原创音乐",
                      "owner" : {
                          "mid" : 20484551,
                          "name" : "凹凸君说",
                          "face" : "http:\/\/i2.hdslb.com\/bfs\/face\/d82be1e7132697946d3d6b6cd4cc07e2ff687215.jpg"
                      },
                      "coins" : 2,
                      "tags" : [
                                "夏一可",
                                "国人男声",
                                "原创编曲",
                                "守望先锋",
                                "凹凸君说",
                                "午时已到",
                                "夏家三千菜",
                                "夏姬八唱"
                                ],
                      "time" : 1474205206,
                      "pic" : "http:\/\/i0.hdslb.com\/bfs\/archive\/0be59f2ad8ebfeff9ffc02b6c958a1a106f2b51c.jpg",
                      "title" : "【凹凸君说】夏家三千菜 【给夏一可夏姬八唱首歌】",
                      "desc" : "早早答应@夏一可  女王大人要写歌给她～然而一直拖到现在。。。不过昨晚正好看到有人说手艺人拖延不叫拖延！叫艺术沉淀需要时间的洗礼！于是就洗礼出了这首歌！有没有摇起来滚起来的感觉？感谢女王大人的耐心等待和种子提供~\n微博：@凹凸君说 weibo.com\/aotujunshuo\n编曲：土司、STML\n填词：土司\nPV：aoto\n再次感谢@夏一可 ~\n",
                      "ctime" : 1474014991,
                      "ip" : "27.217.132.88",
                      "stat" : {
                          "favorite" : 11771,
                          "view" : 211838,
                          "coin" : 13490,
                          "share" : 1873,
                          "reply" : 1098,
                          "danmaku" : 1574,
                          "now_rank" : 0,
                          "his_rank" : 64
                      },
                      "duration" : 244,
                      "tid" : 28,
                      "aid" : 6303824,
                      "copyright" : 1
                  },
                  {
                      "pubdate" : 1473750990,
                      "state" : 0,
                      "attribute" : 540672,
                      "rights" : {
                          "movie" : 0,
                          "elec" : 0,
                          "pay" : 0,
                          "download" : 0,
                          "bp" : 0
                      },
                      "tname" : "翻唱",
                      "owner" : {
                          "mid" : 8919801,
                          "name" : "33是抠脚kami",
                          "face" : "http:\/\/i0.hdslb.com\/bfs\/face\/46c55faad3dd600bebf23e3e69d1a2053c405a73.jpg"
                      },
                      "coins" : 2,
                      "tags" : [
                                "岁月神偷",
                                "翻唱",
                                "金玟岐"
                                ],
                      "time" : 1473758355,
                      "pic" : "http:\/\/i1.hdslb.com\/bfs\/archive\/33ee966a9a144f464072bae2ed4bf45d9b123e4f.jpg",
                      "title" : "【33是抠脚kami【翻唱】岁月神偷",
                      "desc" : "米纳桑好啊我是33\n这是我第一次投稿翻唱作品\n非专业录制\n喜欢的小伙伴投个硬币吧~\n么么哒⁄(⁄ ⁄•⁄ω⁄•⁄ ⁄)⁄",
                      "ctime" : 1473750990,
                      "ip" : "27.217.132.88",
                      "stat" : {
                          "favorite" : 4,
                          "view" : 163,
                          "coin" : 60,
                          "share" : 2,
                          "reply" : 24,
                          "danmaku" : 20,
                          "now_rank" : 0,
                          "his_rank" : 0
                      },
                      "duration" : 247,
                      "tid" : 31,
                      "aid" : 6262080,
                      "copyright" : 1
                  },
                  {
                      "tname" : "其他国家",
                      "ip" : "27.217.132.88",
                      "tid" : 83,
                      "title" : "【惊悚\/灾难】釜山行 2016 中文字幕 1080P 孔侑 郑有美 【TSKS】",
                      "time" : 1473748211,
                      "ctime" : 1473680355,
                      "duration" : 7080,
                      "tags" : [
                                "催泪",
                                "丧尸",
                                "火车",
                                "好片不解释",
                                "釜山行",
                                "尸速列车",
                                "全员奔跑啊",
                                "赤手空拳打丧尸之大叔"
                                ],
                      "owner" : {
                          "mid" : 2028824,
                          "name" : "mpor2",
                          "face" : "http:\/\/i2.hdslb.com\/bfs\/face\/7df214e54e255c862e0b0c9980ec2dc4bf228895.jpg"
                      },
                      "attribute" : 524288,
                      "aid" : 6254109,
                      "pubdate" : 1473680355,
                      "state" : 0,
                      "stat" : {
                          "favorite" : 118076,
                          "view" : 0,
                          "coin" : 24429,
                          "share" : 24239,
                          "reply" : 13055,
                          "danmaku" : 331001,
                          "now_rank" : 0,
                          "his_rank" : 0
                      },
                      "access" : 10000,
                      "pic" : "http:\/\/i2.hdslb.com\/bfs\/archive\/9c8efd5179ab9994751649476775d39ddbbbb3bb.jpg",
                      "coins" : 1,
                      "desc" : "直传 链接：http:\/\/pan.baidu.com\/s\/1slrgz8p 密码：qkrm  抓紧存咯~",
                      "copyright" : 2,
                      "rights" : {
                          "movie" : 0,
                          "elec" : 0,
                          "pay" : 0,
                          "download" : 0,
                          "bp" : 0
                      }
                  }
                  ]
    }
}*/