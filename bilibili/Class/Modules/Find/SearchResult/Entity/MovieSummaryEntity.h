//
//  movieSummaryEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieSummaryEntity : NSObject

@property(nonatomic,strong)NSString* param;//试了一下应该是Aid

@property(nonatomic,strong)NSString* staff;//制作人员

@property(nonatomic,strong)NSString* area;//地区

@property(nonatomic,strong)NSString* actors;//演员

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@property(nonatomic,strong)NSString* screen_date;

//@property(nonatomic,strong)NSString* desc;
@end
/*
{
    "param" : "4290449",
    "staff" : "导演：王小帅\n编剧：王小帅",
    "uri" : "bilibili:\/\/video\/4290449",
    "area" : "中国大陆、法国",
    "goto" : "av",
    "title" : "我11",
    "desc" : "20世纪70年代，西南三线地区，无数的上海人怀着崇高的理想来到这片贫瘠的土地建设国家，付出莫大的牺牲。此时此刻，文革的余威仍在，各国营单位乱相未除，而在子弟学校就读的少年王憨（刘文卿 饰）则和八拉头（张珂源 饰）、小老鼠（钟国流星 饰）、卫军（楼逸昊 饰）等几个伙伴过着无 忧无虑的快乐生活。王憨广播体操动作标准，被选为领操员，为此软磨硬泡求妈妈（闫妮 饰）为他做了一件崭新的白衬衣。可是他在河边玩时衬衣意外掉入水中，结果意外遭遇了被警察追捕的杀人犯谢觉强（王紫逸 饰）。\n时代的大背景下，放眼尽是令人百思不得其解的怪现象，小人物只有随波逐流，身不由己……",
    "length" : 110,
    "cover" : "http:\/\/i0.hdslb.com\/bfs\/bangumi\/794f7ead58119b299caa3b2d6bcb6f1af8ea7e7a.jpg",
    "official_verify" : {
        "type" : 0,
        "desc" : ""
    },
    "screen_date" : "2012-05-18 00:00:00",
    "cover_mark" : "免费观看",
    "total_count" : 0,
    "actors" : "闫妮、刘文卿、莫诗旎、王景春、王紫逸、乔任梁、于越、张珂源、钟国流星、楼逸昊",
    "status" : 2
}
*/