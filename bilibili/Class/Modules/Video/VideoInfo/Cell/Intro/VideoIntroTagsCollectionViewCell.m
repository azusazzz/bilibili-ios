//
//  VideoIntroTagsCollectionViewCell.m
//  bilibili fake
//
//  Created by cezr on 16/8/9.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "VideoIntroTagsCollectionViewCell.h"


#define TagHeight 30.0


@interface VideoIntroTagsCollectionViewCell ()
{
    NSMutableArray<UIButton *> *_tagButtons;
}
@end

@implementation VideoIntroTagsCollectionViewCell

+ (CGFloat)heightForWidth:(CGFloat)width tags:(NSArray<NSString *> *)tags {
    if ([tags count] == 0) {
        return 0;
    }
    
    CGRect rect = CGRectMake(0, 15+15+15, 0, TagHeight);
    for (NSInteger i=0; i<tags.count; i++) {
        
        CGFloat textWidth = [tags[i] boundingRectWithSize:CGSizeMake(99999, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.width;
        
        if (rect.origin.x + rect.size.width + 10 + textWidth + TagHeight > width) {
            rect.origin.x = 10;
            rect.origin.y += rect.size.height+10;
        }
        else {
            rect.origin.x += rect.size.width + 10;
        }
        rect.size.width = textWidth + TagHeight;
    }
    
    return rect.origin.y + rect.size.height + 15;
}

- (void)onClickTag:(UIButton *)button {
    !_onClickTag ?: _onClickTag(button.titleLabel.text);
}

- (void)setTags:(NSArray<NSString *> *)tags {
    NSInteger tagsCount = [tags count];
    
    for (NSInteger i=[_tagButtons count]; i<tagsCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:ColorWhite(34) forState:UIControlStateNormal];
        button.titleLabel.font = Font(12);
        button.layer.cornerRadius = 12;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = ColorWhite(200).CGColor;
        [button addTarget:self action:@selector(onClickTag:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_tagButtons addObject:button];
    }
    
    NSInteger count = [_tagButtons count];
    for (NSInteger i=count-1; i>=tagsCount; i--) {
        [_tagButtons[i] removeFromSuperview];
        [_tagButtons removeLastObject];
    }
    
    CGRect rect = CGRectMake(0, 15+15+15, 0, TagHeight);
    
    for (NSInteger i=0; i<tagsCount; i++) {
        _tagButtons[i].tag = i;
        
        CGFloat width = [tags[i] boundingRectWithSize:CGSizeMake(99999, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.width;
        
        if (rect.origin.x + rect.size.width + 10 + width + TagHeight > self.width) {
            rect.origin.x = 10;
            rect.origin.y += rect.size.height+10;
        }
        else {
            rect.origin.x += rect.size.width + 10;
        }
        rect.size.width = width + TagHeight;
        
        _tagButtons[i].frame = rect;
        
        [_tagButtons[i] setTitle:tags[i] forState:UIControlStateNormal];
    }
    
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWhite(247);
        
        _tagButtons = [NSMutableArray array];
        
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

@end
