//
//  UserInfoCardEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoCardEntity : NSObject

@property(nonatomic,strong)NSString* mid;

@property(nonatomic,strong)NSString* sex;

@property(nonatomic,strong)NSString* name;

@property(nonatomic,strong)NSString* sign;//个性签名

@property(nonatomic,strong)NSArray* attentions;//关注人的mid列表


@property(nonatomic,strong)NSString* rank;//
@property(nonatomic,strong)NSString* place;//地址
@property(nonatomic,strong)NSString* birthday;//生日

@property(nonatomic)BOOL approve;//是否认证过？不确定
//认证信息
@property(nonatomic,strong)NSDictionary* official_verify;
@property(nonatomic,readonly)NSInteger verifyType;//不太明白
@property(nonatomic,strong,readonly)NSString* officialDesc;



@property(nonatomic,strong)NSDictionary* level_info;
@property(nonatomic,readonly)NSInteger current_level;//等级
@property(nonatomic,readonly)NSInteger current_min;//最少经验
@property(nonatomic,readonly)NSInteger current_exp;//当前经验
@property(nonatomic,readonly)CGFloat next_exp;//下一级经验

@property(nonatomic)NSInteger fans;//粉丝
@property(nonatomic,strong)NSString* face;//头像
@property(nonatomic)NSInteger regtime;//注册时间


@end
//普通帐号
/*
{
    "card" : {
        "rank" : "10000",
        "place" : "",
        "birthday" : "1995-11-22",
        "pendant" : {
            "expire" : 0,
            "name" : "",
            "pid" : 0,
            "image" : ""
        },
        "approve" : false,
        "official_verify" : {
            "type" : -1,
            "desc" : ""
        },
        "mid" : "2610184",
        "sex" : "男",
        "friend" : 4,
        "nameplate" : {
            "level" : null,
            "condition" : null,
            "nid" : 0,
            "name" : "",
            "image" : "",
            "image_small" : ""
        },
        "name" : "银雪皓月",
        "attention" : 4,
        "sign" : "个性签名",
        "level_info" : {
            "current_level" : 4,
            "current_min" : 4500,
            "current_exp" : 6032,
            "next_exp" : 10800
        },
        "DisplayRank" : "10000",
        "spacesta" : 0,
        "article" : 0,
        "fans" : 1,
        "face" : "http:\/\/i0.hdslb.com\/bfs\/face\/e674db2e1d7d59b92fb0193a0d5d862c98bded99.jpg",
        "coins" : 0,
        "regtime" : 1382228877,
        "attentions" : [
                        732364,
                        12201225,
                        28328084,
                        893053
                        ],
        "description" : ""
    },
    "code" : 0
}*/

//认证帐号
/*
{
    "card" : {
        "rank" : "10000",
        "place" : "北京市 海淀区",
        "birthday" : "1980-01-01",
        "pendant" : {
            "expire" : 0,
            "name" : "",
            "pid" : 0,
            "image" : ""
        },
        "approve" : true,
        "official_verify" : {
            "type" : 1,
            "a" : "腾讯动漫官方账号"
        },
        "mid" : "732364",
        "sex" : "女",
        "friend" : 0,
        "nameplate" : {
            "level" : null,
            "condition" : null,
            "nid" : 0,
            "name" : "",
            "image" : "",
            "image_small" : ""
        },
        "name" : "腾讯动漫",
        "attention" : 0,
        "sign" : "企鹅娘官微 @腾讯动漫微博 求关注！\r\n企鹅娘招责编啦！！详细请点：http:\/\/dwz.cn\/3OyLr4",
        "level_info" : {
            "current_level" : 6,
            "current_min" : 28800,
            "current_exp" : 799995,
            "next_exp" : "-"
        },
        "DisplayRank" : "10000",
        "spacesta" : 0,
        "article" : 0,
        "fans" : 335187,
        "face" : "http:\/\/i1.hdslb.com\/bfs\/face\/251429116f77ccaf4e24ef56bf2bbb89a31c3043.jpg",
        "coins" : 0,
        "regtime" : 1357978526,
        "attentions" : [
        
        ],
        "description" : "腾讯动漫官方账号"
    },
    "code" : 0
}*/