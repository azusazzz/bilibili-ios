//
//  VideoTagsView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/20.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoTagsView.h"




@implementation VideoTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = Font(13);
        titleLabel.text = @"视频相关";
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 10;
            make.top.offset = 15;
            make.width.offset = 100;
            make.height.offset = 15;
        }];
        
    }
    return self;
}

- (void)onClickTag:(UIButton *)button {
    
}


- (void)setupTags:(NSArray<NSString *> *)tags {
    
    if (tags.count == 0) {
        self.height = 15+15+15;
        return;
    }
    

    
    CGRect rect = CGRectMake(0, 15+15+15, 0, TagHeight);
    for (int i=0; i<tags.count; i++) {
        
        CGFloat width = [tags[i] boundingRectWithSize:CGSizeMake(99999, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.width;
        
        if (rect.origin.x + rect.size.width + 10 + width + TagHeight > self.width) {
            rect.origin.x = 10;
            rect.origin.y += rect.size.height+10;
        }
        else {
            rect.origin.x += rect.size.width + 10;
        }
        rect.size.width = width + TagHeight;
        
        
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeSystem];
        tagButton.backgroundColor = [UIColor whiteColor];
        [tagButton setTitle:tags[i] forState:UIControlStateNormal];
        [tagButton setTitleColor:ColorWhite(34) forState:UIControlStateNormal];
        tagButton.tag = i;
        tagButton.titleLabel.font = Font(12);
        tagButton.frame = rect;
        tagButton.layer.cornerRadius = 12;
        tagButton.layer.masksToBounds = YES;
        tagButton.layer.borderWidth = 0.5;
        tagButton.layer.borderColor = ColorWhite(200).CGColor;
        [tagButton addTarget:self action:@selector(onClickTag:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tagButton];
        
        
    }
    
    
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.offset = rect.origin.y + rect.size.height + 15;
//    }];
    
    self.height = rect.origin.y + rect.size.height + 15;
    
}


@end
