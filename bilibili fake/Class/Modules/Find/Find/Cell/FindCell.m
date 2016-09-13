//
//  FindCell.m
//  bilibili fake
//
//  Created by cxh on 16/9/6.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "FindCell.h"
#import <Masonry.h>
#import "Macro.h"

@implementation FindCell{
    UIImageView* iconImageView;
    UILabel* titleLabel;

    UIView* separator;
}
-(void)dealloc{
    //NSLog(@"%s",__FUNCTION__);
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        separator = ({
            UIView* view = [UIView new];
            view.backgroundColor =  ColorRGB(200, 200, 200);
            [self addSubview:view];
            view;
        });
        iconImageView = ({
            UIImageView* imageView =[UIImageView new];
            [self addSubview:imageView];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView;
        });
        
        titleLabel = ({
            UILabel* label = [UILabel new];
            [self addSubview:label];
            label.textColor = ColorRGB(23, 23, 23);
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor blackColor];
            label;
        });
        
        UIImageView* rightImageView = ({
             UIImageView* imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:@"common_rightArrowShadow"];
            [self addSubview:imageView];
            imageView;
        });
        

        
        //layout
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self);
            make.height.equalTo(@(0.4));
        }];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
            make.width.equalTo(iconImageView.mas_height);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(iconImageView.mas_right).offset(10);
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(titleLabel.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self);
            make.height.equalTo(@14);
            make.width.equalTo(rightImageView.mas_height);
        }];
    }
    return self;
}

-(void)setIconImage:(UIImage*)image TitleText:(NSString*)text  line:(BOOL)line{
    //分割线
   separator.hidden = !line;
    if(image)[iconImageView setImage:image];
    if(text)[titleLabel setText:text];

}
@end
