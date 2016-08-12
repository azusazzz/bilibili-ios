//
//  findView_Cell.m
//  bilibili fake
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindViewCell.h"
#import <Masonry.h>
#import "Macro.h"

@implementation FindViewCell{
    UIImageView* icon_imageView;
    UILabel* title_Label;
    UIImageView* imageView;
}

-(void)setIconImage:(UIImage*)image TitleText:(NSString*)text{
    //分割线
    
    if ([text isEqualToString:@"原创排行榜"]) {
        UIView* separator = [UIView new];
        separator.backgroundColor =  ColorRGB(200, 200, 200);
        [self addSubview:separator];
        
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self);
            make.height.equalTo(@(0.4));
        }];
    }
    
    icon_imageView = [UIImageView new];
    [self addSubview:icon_imageView];
    icon_imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    title_Label = [UILabel new];
    [self addSubview:title_Label];
    title_Label.textColor = ColorRGB(23, 23, 23);
    title_Label.font = [UIFont systemFontOfSize:14];
    title_Label.textColor = [UIColor blackColor];
    
    imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"common_rightArrowShadow"];
    [self addSubview:imageView];
    
    

    
    [icon_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(icon_imageView.mas_height);
    }];
    

    [title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(icon_imageView.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(title_Label.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.height.equalTo(@14);
        make.width.equalTo(imageView.mas_height);
    }];
    if(image)[icon_imageView setImage:image];
    if(text)[title_Label setText:text];

}
@end
