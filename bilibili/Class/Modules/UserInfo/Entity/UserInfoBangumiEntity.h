//
//  UserInfoBangumiEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UBangumiEntity : NSObject

@property(nonatomic)NSInteger is_finish;//是否更新完毕

@property(nonatomic)NSInteger newest_ep_index;

@property(nonatomic,strong)NSString* cover;
@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* season_id;

@end

@interface UserInfoBangumiEntity : NSObject

@property(nonatomic)NSInteger count;
@property(nonatomic)NSInteger pages;
@property(nonatomic,strong)NSMutableArray<UBangumiEntity*>* result;

@end
/*
{
    "status" : true,
    "data" : {
        "count" : 2,
        "pages" : 1,
        "result" : [
                    {
                        "is_finish" : 0,
                        "evaluate" : "",
                        "season_id" : "5029",
                        "brief" : "妻子亡故后，独自努力养育女儿的数学教师·犬冢。不擅长料理又是个味觉白痴的他，在偶然之下和学生·饭田小...",
                        "favorites" : 418318,
                        "title" : "天真与闪电",
                        "newest_ep_index" : 12,
                        "last_ep_index" : 0,
                        "cover" : "http:\/\/i0.hdslb.com\/bfs\/bangumi\/5626f7afbd39a0b4561dea5bd267ba1ef2248c0d.jpg",
                        "share_url" : "http:\/\/bangumi.bilibili.com\/anime\/5029\/",
                        "total_count" : 12
                    },
                    {
                        "is_finish" : 0,
                        "evaluate" : "",
                        "season_id" : "5063",
                        "brief" : "电视动画《DAYS》改编自日本漫画家安田刚士原作的同名漫画。在《周刊少年Magazine》（讲谈社）...",
                        "favorites" : 174660,
                        "title" : "DAYS",
                        "newest_ep_index" : 12,
                        "last_ep_index" : 0,
                        "cover" : "http:\/\/i0.hdslb.com\/bfs\/bangumi\/20f05ecc4c50d560814e511ced4205f37e640501.jpg",
                        "share_url" : "http:\/\/bangumi.bilibili.com\/anime\/5063\/",
                        "total_count" : 24
                    }
                    ]
    }
}
 */