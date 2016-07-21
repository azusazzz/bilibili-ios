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
            [button addTarget:self action:@selector(onClickItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_items addObject:button];
        }];
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = ColorRGB(219, 92, 92);
        [self addSubview:_bottomLineView];
        
    }
    return self;
}

- (void)onClickItem:(UIButton *)button {
    _onClickItem ? _onClickItem(button.tag) : NULL;
}

- (NSInteger)currentIndex; {
    return _index;
}

- (void)setContentOffset:(CGFloat)contentOffset; {
    
    
    
    _bottomLineView.x =  _edgeInsets.left + (self.width-_edgeInsets.left-_edgeInsets.right) * contentOffset;
    NSInteger index = (NSInteger)((_bottomLineView.x-_edgeInsets.left) / self.itemWidth);
    
    
    CGFloat bottomOffsetX = _bottomLineView.x - _edgeInsets.left - index * self.itemWidth;
    if (bottomOffsetX > 0) {
        CGFloat progress = bottomOffsetX / self.itemWidth;
        [_items[index] setTitleColor:ColorRGB(219 - 19*progress, 92 + 118*progress, 92 + 118*progress) forState:UIControlStateNormal];
        [_items[index+1] setTitleColor:ColorRGB(200+19*progress, 200-118*progress, 200-118*progress) forState:UIControlStateNormal];
        
    }
    else if (bottomOffsetX < 0) {
        CGFloat progress = 1 - (bottomOffsetX) / self.itemWidth;
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
    
    CGFloat itemWidth = (self.bounds.size.width - _edgeInsets.left - _edgeInsets.right) / _items.count;
    [_items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(_edgeInsets.left + itemWidth * idx, _edgeInsets.top, itemWidth, self.bounds.size.height-_edgeInsets.top-_edgeInsets.bottom);
    }];
    
    _bottomLineView.frame = CGRectMake(_items[_index].x, self.height-2 - _edgeInsets.bottom, _items[_index].width, 2);
    
    [super layoutSubviews];
}

- (CGFloat)itemWidth {
    return (self.bounds.size.width - _edgeInsets.left - _edgeInsets.right) / _items.count;
}

@end
