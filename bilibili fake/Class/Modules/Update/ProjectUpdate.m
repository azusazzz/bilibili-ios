//
//  ProjectUpdate.m
//  bilibili fake
//
//  Created by cxh on 16/11/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ProjectUpdate.h"
static ProjectUpdate* shareProjecUpdate;
@implementation ProjectUpdate
+(instancetype)share{
    @synchronized (self) {
        if (!shareProjecUpdate) {
            shareProjecUpdate = [[self alloc] init];
        }
    }
    return shareProjecUpdate;
}

-(void)update{
    
}
@end
