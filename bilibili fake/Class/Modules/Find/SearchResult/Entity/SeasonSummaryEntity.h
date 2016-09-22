//
//  seasonSummaryEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeasonSummaryEntity : NSObject

@property(nonatomic)NSInteger finish;//是否完结

@property(nonatomic,strong)NSString* newest_season;

@property(nonatomic,strong)NSString* index;//有几话

@property(nonatomic,strong)NSString* param;//番剧id

@property(nonatomic,strong)NSString* cat_desc;

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@end
/*
{
    "finish" : 1,
    "index" : "13",
    "param" : "1561",
    "cat_desc" : "TV(3) ",
    "uri" : "bilibili:\/\/bangumi\/season\/1561",
    "newest_cat" : "tv",
    "goto" : "bangumi",
    "title" : "歌之☆王子殿下 真爱1000",
    "newest_season" : "第一季",
    "cover" : "http:\/\/i0.hdslb.com\/bfs\/bangumi\/3b599785237611522ac23718950849bcb3e9577c.jpg",
    "official_verify" : {
        "type" : 0,
        "desc" : ""
    },
    "total_count" : 13,
    "status" : 0
}
*/