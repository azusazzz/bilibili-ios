//
//  UpdateAddressEntity.h
//  bilibili fake
//
//  Created by cxh on 16/11/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateAddressEntity : NSObject

@property(nonatomic,strong)NSString* version;

@property(nonatomic,strong)NSString* path;

@property(nonatomic,strong)NSArray<NSString*>* files;

@end
