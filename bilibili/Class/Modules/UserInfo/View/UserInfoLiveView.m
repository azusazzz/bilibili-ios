//
//  UserInfoLiveView.m
//  bilibili fake
//
//  Created by cxh on 16/9/18.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UserInfoLiveView.h"

@implementation UserInfoLiveView{
    UIButton* mainBtn;
    UIImageView* btnImageview;
}

-(instancetype)init{

    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = ColorWhite(255);
        //self.userInteractionEnabled = YES;
        mainBtn = ({
            NSString* str = @"TA现在并没有直播，去订阅他的直播";
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attributedStr addAttribute:NSForegroundColorAttributeName
                                  value:ColorWhite(100)
                                  range:NSMakeRange(0, str.length)];
            [attributedStr addAttribute:NSForegroundColorAttributeName
                        value:CRed
                        range:[str rangeOfString:@"订阅"]];
            
            //home_region_icon_live
            
            UIButton* btn = [[UIButton alloc] init];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setAttributedTitle:attributedStr forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 20)];
            [self addSubview:btn];
            btn;
        });
        btnImageview = ({
            UIImageView* view = [[UIImageView alloc] init];
            //view.contentMode = UIViewContentModeScaleAspectFit;
            view.image = [UIImage imageNamed:@"home_region_icon_live"];
            [mainBtn addSubview:view];
            view;
        });
        
        //layout
        [mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [btnImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainBtn).offset(15);
            make.top.equalTo(mainBtn).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        //actions
        [mainBtn addTarget:self action:@selector(onClickMainBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)onClickMainBtn{
    _onClickPlay?_onClickPlay():NULL;
}



-(void)setEntity:(UserInfoLiveEntity *)entity{
    if (entity.roomStatus) {
        if (entity.liveStatus) {
            NSString* str = [NSString stringWithFormat:@"正在直播“%@”",entity.title];
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attributedStr addAttribute:NSForegroundColorAttributeName
                                  value:CRed
                                  range:NSMakeRange(0, str.length)];
            [mainBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
        }
    }else{
        [mainBtn removeFromSuperview];
    }
}
@end
