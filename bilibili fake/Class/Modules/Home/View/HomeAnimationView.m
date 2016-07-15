//
//  HomeAnimationView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "HomeAnimationView.h"
#import "HomeAnimationRequest.h"

@interface HomeAnimationView ()
<ESRequestDelegate>

@end

@implementation HomeAnimationView

- (instancetype)init; {
    self = [super init];
    if (!self) {
        return self;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    [[HomeAnimationRequest requestWithDelegate:self] start];
    
    return self;
}


#pragma mark - ESRequestDelegate

- (void)requestCompletion:(ESRequest *)request; {
    
    NSLog(@"\n%@", request.responseObject[@"result"][@"categories"]);
    
}


@end
