//
//  HotWorksEntity.h
//  bilibili fake
//
//  Created by C on 16/9/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotWorkEntity.h"

@interface HotWorkListEntity : NSObject

@property(nonatomic,strong)NSMutableArray<HotWorkEntity*>* hotWorkList;

@property(nonatomic,strong)NSMutableArray<NSString*>* hotWorkStrList;

@end
