//
//  VideoPageNameCollectionViewCell.h
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPageNameCollectionViewCell : UICollectionViewCell



@property (strong, nonatomic) NSString *title;

- (void)selectItem:(BOOL)select;


@end
