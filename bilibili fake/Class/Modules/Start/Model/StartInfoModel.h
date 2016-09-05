//
//  StartInfo.h
//  bilibili fake
//
//  Created by C on 16/9/4.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "BaseRequest.h"
#import "StartPageEntity.h"
@interface StartInfoModel : BaseRequest

@property(nonatomic,strong)StartPageEntity* currentStartPage;

@end
