//
//  SpecialSummaryEntity.h
//  bilibili fake
//
//  Created by cxh on 16/9/12.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialSummaryEntity : NSObject

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* cover;

@property(nonatomic,strong)NSString* desc;

@property(nonatomic,strong)NSString* param;

@property(nonatomic)NSInteger play;//播放量

@property(nonatomic)NSInteger archives;//视频数量

@end
/*
 {
 "title":"精灵守护者1",
 "cover":"http://i0.hdslb.com/sp/e1/e1039794c91fc5372e76d49683c85cef.jpg",
 "uri":"bilibili://splist/65468",
 "param":"65468",
 "goto":"sp",
 "play":14589,
 "total_count":0,
 "desc":"　  一次偶然机会，女保镖巴尔莎救下了落入河中的新龙勾皇国王子查穆。将查穆带回宫殿的巴尔莎却被告知赶快带他逃走。查穆身上带有精灵之卵，但却被称为魔物，因而被人追杀。巴尔莎带着查穆一路逃命，并教会了他守身之术。距离精灵之卵的孵化日期越来越近，他们的命运将迎来怎样的考验呢？",
 "official_verify":{
 "type":0,
 "desc":""},
 "archives":1,
 "status":0
 }
 */
