//
//  HomeAnimationModel.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/15.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationModel.h"


@interface HomeAnimationModel ()


@end

@implementation HomeAnimationModel

- (void)setCategoryJSONObject:(id)JSONObject; {
    NSArray *categories = [JSONObject valueForKeyPath:@"result.categories"];
    if (!categories) {
        return;
    }
    
    _categoryEntitys = [NSMutableArray arrayWithCapacity:categories.count];
    
    for (NSDictionary *dict in categories) {
        NSDictionary *category = [dict objectForKey:@"category"];
        NSArray *list = [dict valueForKeyPath:@"list.list"];
        HomeAnimationCategoryEntity *categoryEntity = [HomeAnimationCategoryEntity mj_objectWithKeyValues:category];
        categoryEntity.list = [HomeAnimationCategoryItemEntity mj_objectArrayWithKeyValuesArray:list];
        [_categoryEntitys addObject:categoryEntity];
    }
    
}

@end
