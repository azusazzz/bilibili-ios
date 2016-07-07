//
//  RowBotton.m
//  bilibili fake
//
//  Created by cxh on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RowBotton.h"
typedef void(^BLOCK)(NSInteger btnTag);

@implementation RowBotton{
    NSMutableArray<UIButton *> *_items;
    NSMutableArray<NSString *> *_titles;
    BLOCK _block;
    
    UIScrollView* _mainscr;
    UIFont* _font;
    
}

- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles  Block:(void(^)(NSInteger btnTag))block{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:14];
        _block = block;
        self.backgroundColor = [UIColor whiteColor];
        
        _mainscr = [[UIScrollView alloc] init];
         _mainscr.contentSize = self.frame.size;
        _mainscr.showsHorizontalScrollIndicator = FALSE;
        
        [self addSubview:_mainscr];
        [self setTitles:titles];
    }
    return self;
}

- (void )layoutSubviews{
    _mainscr.frame = self.bounds;
    
    NSLog(@"%f",self.frame.size.width);

    CGFloat mainWidth = self.frame.size.width;
    CGFloat mainHeight = self.frame.size.height;
    CGFloat minWidth = [self getRowMinWidth];
    
    if (self.frame.size.width >= minWidth) {
        
        _mainscr.scrollEnabled = NO;
        _mainscr.contentSize = self.frame.size;
        
        CGFloat Surplusf = (mainWidth - minWidth)/_items.count;
        CGFloat Potomac = 0;
        
        for (int i = 0; i < _items.count; i++) {
            UIButton* btn = _items[i];
            CGFloat w = [self widthWithFont:_font String:btn.titleLabel.text];
            btn.frame = CGRectMake(Potomac, 0, w+Surplusf, mainHeight);
            Potomac+=(w+Surplusf);
        }
        
        
    }else{
        
        
        _mainscr.scrollEnabled = YES;
        _mainscr.contentSize = CGSizeMake(minWidth, mainHeight);
        
        CGFloat Potomac = 0;
        for (int i = 0; i < _items.count; i++) {
            UIButton* btn = _items[i];
            CGFloat w = [self widthWithFont:_font String:btn.titleLabel.text];
            btn.frame = CGRectMake(Potomac, 0, w, mainHeight);
            Potomac+=w;
        }
    
    }
}




- (void)setTitles:(NSMutableArray<NSString *> *)titles{
    if(_items){
        for (UIButton* btn in _items) {
            [btn removeFromSuperview];
        }
         [_items removeAllObjects];
    }
   
    
    _titles = titles;
    _items = [[NSMutableArray alloc] init];
    for (int i = 0; i < _titles.count; i++)
    {
        UIButton* btn = [[UIButton alloc] init];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:ColorRGB(100, 100, 100) forState:UIControlStateNormal];
        [_mainscr addSubview:btn];
        [_items addObject:btn];
    }
    
}



-(CGFloat)getRowMinWidth{
    CGFloat minWidth  = 0;
    for (int i = 0; i < _titles.count; i++) {
        minWidth += [self widthWithFont:_font String:_titles[i]];
    }
    return minWidth;
}


-(CGFloat)widthWithFont:(UIFont*)font String:(NSString*)str{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    return rect.size.width+10;
}


@end
