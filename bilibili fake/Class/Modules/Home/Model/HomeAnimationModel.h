//
//  HomeAnimationModel.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeAnimationCategoryEntity.h"

@interface HomeAnimationModel : NSObject

@property (strong, nonatomic) NSArray *dataSource;

@property (strong, nonatomic) NSMutableArray *categoryEntitys;

- (void)setCategoryJSONObject:(id)JSONObject;

@end
