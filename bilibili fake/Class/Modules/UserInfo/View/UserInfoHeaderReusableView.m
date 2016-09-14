//
//  UserInfoHeaderReusableView.m
//  bilibili fake
//
//  Created by cxh on 16/9/14.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoHeaderReusableView.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>

@implementation UserInfoHeaderReusableView{
    UIImageView* faceImageView;

}

+(CGFloat)height{
    return 270;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        faceImageView = ({
            UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 100, 100)];
            [self addSubview:view];
            view;
        });
        
        //layout
//        [faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(CGPointMake(70 , 120));
//            make.size.mas_equalTo(CGSizeMake(96, 96));
//        }];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath* rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0 , 120 , rect.size.width, 220)];
    UIBezierPath* arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(70, 120) radius:50 startAngle:M_PI endAngle:0 clockwise:YES];
    [rectPath appendPath:arcPath];
    [ColorWhite(255) setFill];
    [rectPath fill];
}

-(void)setEntity:(UserInfoCardEntity *)entity{
    if (entity) {
        _entity = entity;
        [faceImageView sd_setImageWithURL:[NSURL URLWithString:entity.face]];
    }

}


@end
