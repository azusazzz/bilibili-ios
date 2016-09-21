//
//  UserInfoSubmitVideosEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitVideoEntity : NSObject

@property(nonatomic,strong)NSString* pic;
@property(nonatomic,strong)NSString* title;
@property(nonatomic)NSInteger comment;//弹幕
@property(nonatomic)NSInteger play;
@property(nonatomic)NSInteger aid;
@end

@interface UserInfoSubmitVideosEntity : NSObject

@property(nonatomic)NSInteger count;
@property(nonatomic)NSInteger pages;
@property(nonatomic,strong)NSMutableArray<SubmitVideoEntity*>* vlist;

@end
/*
{
    "status" : true,
    "data" : {
        "pages" : 1,
        "vlist" : [
                   {
                       "typeid" : 130,
                       "play" : 23,
                       "mid" : 2610184,
                       "subtitle" : "",
                       "review" : 11,
                       "favorites" : 0,
                       "author" : "银雪皓月",
                       "description" : "自制 新人第一次投稿。",
                       "pic" : "http:\/\/i0.hdslb.com\/video\/f1\/f1c208704cc5dd7c647766317dae288c.jpg",
                       "title" : "【新人】【点了浪费时间】summer",
                       "comment" : 49,
                       "length" : "06:25",
                       "created" : "2016-02-01 21:49:20",
                       "video_review" : 49,
                       "aid" : 3727026,
                       "copyright" : "Original"
                   }
                   ],
        "tlist" : {
            "3" : {
                "tid" : 3,
                "name" : "音乐",
                "count" : 1
            }
        },
        "count" : 1
    }
}*/
