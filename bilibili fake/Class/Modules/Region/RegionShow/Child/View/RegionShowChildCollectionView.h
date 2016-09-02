//
//  RegionShowChildCollectionView.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/9/1.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionShowChildEntity.h"

@interface RegionShowChildCollectionView : UICollectionView

@property (strong, nonatomic) RegionShowChildEntity *regionShowChild;

@property (strong, nonatomic) void (^handleDidSelectedVideo)(RegionShowVideoEntity *video);

@end
