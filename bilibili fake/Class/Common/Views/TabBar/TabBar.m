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
            if (idx == _index) {
                [button setTitleColor:ColorRGB(219, 92, 92) forState:UIControlStateNormal];
            }
            else {
                [button setTitleColor:ColorWhite(200) forState:UIControlStateNormal];
            }
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
    NSInteger index = (NSInteger)(_bottomLineView.x / _itemWidth);
    
    
    CGFloat bottomOffsetX = _bottomLineView.x - index * _itemWidth;
    if (bottomOffsetX > 0) {
        CGFloat progress = bottomOffsetX / _itemWidth;
        [_items[index] setTitleColor:ColorRGB(219 - 19*progress, 92 + 118*progress, 92 + 118*progress) forState:UIControlStateNormal];
        [_items[index+1] setTitleColor:ColorRGB(200+19*progress, 200-118*progress, 200-118*progress) forState:UIControlStateNormal];
        
    }
    else if (bottomOffsetX < 0) {
        CGFloat progress = 1 - (bottomOffsetX) / _itemWidth;
        [_items[_index] setTitleColor:ColorRGB(219 - 19*progress, 92 + 118*progress, 92 + 118*progress) forState:UIControlStateNormal];
        [_items[index] setTitleColor:ColorRGB(200+19*progress, 200-118*progress, 200-118*progress) forState:UIControlStateNormal];
    }
    else {
        if (_index != index) {
            [_items[_index] setTitleColor:ColorWhite(200) forState:UIControlStateNormal];
            [_items[index] setTitleColor:ColorRGB(219, 92, 92) forState:UIControlStateNormal];
            _index = index;
        }
    }
    
    
}

- (void)setTitle:(NSString *)title forIndex:(NSInteger)index; {
    [_items[index] setTitle:title forState:UIControlStateNormal];
}



- (void)selectedItem:(UIButton *)itemButton; {
    [self.delegate tabBar:self didSelectIndex:itemButton.tag];
}

- (void)layoutSubviews; {
    
    CGFloat itemWidth = _itemWidth;
    [_items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(itemWidth * idx, 0, itemWidth, self.bounds.size.height);
    }];
    
    _bottomLineView.frame = CGRectMake(_items[_index].x, self.height-2, _items[_index].width, 2);
    
    [super layoutSubviews];
}

@end
