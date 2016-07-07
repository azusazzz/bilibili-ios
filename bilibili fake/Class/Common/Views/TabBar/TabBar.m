//
//  TabBar.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/5.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "TabBar.h"

@interface TabBar ()
{
    NSMutableArray<UIButton *> *_items;
    UIView *_bottomLineView;
    
    NSInteger _index;
}
@end

@implementation TabBar

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles; {
    if (self = [super init]) {
        _items = [NSMutableArray arrayWithCapacity:titles.count];
        
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:obj forState:UIControlStateNormal];
            [button setTitleColor:ColorRGB(219, 92, 92) forState:UIControlStateNormal];
            button.titleLabel.font = Font(14);
            button.tag = idx;
            [self addSubview:button];
            [_items addObject:button];
        }];
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = ColorRGB(219, 92, 92);
        [self addSubview:_bottomLineView];
        
    }
    return self;
}

- (NSInteger)currentIndex; {
    return _index;
}

- (void)setContentOffset:(CGFloat)contentOffset; {
    _bottomLineView.x = self.width * contentOffset;
}

- (void)setTitle:(NSString *)title forIndex:(NSInteger)index; {
    [_items[index] setTitle:title forState:UIControlStateNormal];
}



- (void)selectedItem:(UIButton *)itemButton; {
    [self.delegate tabBar:self didSelectIndex:itemButton.tag];
}

- (void)layoutSubviews; {
    
    CGFloat itemWidth = self.bounds.size.width / _items.count;
    [_items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(itemWidth * idx, 0, itemWidth, self.bounds.size.height);
    }];
    
    _bottomLineView.frame = CGRectMake(_items[_index].x, self.height-2, _items[_index].width, 2);
    
    [super layoutSubviews];
}

@end
