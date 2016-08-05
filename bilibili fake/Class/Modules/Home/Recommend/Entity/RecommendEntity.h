//
//  RecommendEntity.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecommendBodyEntity.h"
#import "RecommendBannerEntity.h"

@interface RecommendEntity : NSObject

@property (strong, nonatomic) NSString *param;

@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSString *style;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSArray<RecommendBodyEntity *> *body;

@property (strong, nonatomic) NSArray<RecommendBannerEntity *> *banner_top;

@property (strong, nonatomic) NSArray<RecommendBannerEntity *> *banner_bottom;



@property (strong, nonatomic) NSString *logoIconNmae;

@end
