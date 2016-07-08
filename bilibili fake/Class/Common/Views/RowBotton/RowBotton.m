//
//  RowBotton.m
//  bilibili fake
//
//  Created by cxh on 16/7/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "RowBotton.h"
#import "Macro.h"


typedef void(^BLOCK)(NSInteger btnTag);

@implementation RowBotton{
    NSMutableArray<UIButton *> *_items;
    NSMutableArray<NSString *> *_titles;
    BLOCK _block;
    RowBottonStyle _style;
    
    UIScrollView* _mainscr;
    UIFont* _font;
    
    UIView* SelectedbgView;
    NSInteger _spacing;
}
- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles  Block:(void(^)(NSInteger btnTag))block{
  return   [self initWithTitles:titles Style:RowBottonDefaultStyle Block:block];
}

- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles Style:(RowBottonStyle)style  Block:(void(^)(NSInteger btnTag))block{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:14];
        _block = block;
        _style = style;
        _spacing = 0;
        self.backgroundColor = [UIColor whiteColor];
        _Selectedtag = -1;
        
        _mainscr = [[UIScrollView alloc] init];
         _mainscr.contentSize = self.frame.size;
        _mainscr.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:_mainscr];
        [self setTitles:titles];
        
        if (style == RowBottonDefaultStyle) {
            SelectedbgView = [[UIView alloc] init];
            SelectedbgView.backgroundColor = ColorRGB(252, 142, 175);
            [_mainscr addSubview:SelectedbgView];
            
        }
       // [self setSelectedBotton:_Selectedtag];
    }
    return self;
}

- (void)setSelecteBlock:(void(^)(NSInteger btnTag))block{
    _block = block;
}

/**
 *  设置间距
 */
- (void)setSpacing:(NSInteger)spacing{
    _spacing = spacing;
    [self layoutSubviews];
}
//根据标题重新设置按钮数组
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
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [_mainscr addSubview:btn];
        [_items addObject:btn];
    }
    
}


//按钮点击事件处理
-(void)btnAction:(id)sender{
    UIButton* botton = sender;
    if(_block)
    _block(botton.tag);
    [self setSelectedBotton:botton.tag];
}
-(void)setSelectedBotton:(NSInteger)tag{
    CGFloat time = 0.2;
    if (_Selectedtag == -1) {
        time = 0.0;
        _Selectedtag = 0;
        tag = 0;
    }
    [UIView animateWithDuration:time animations:^{
        
        
        if (_style == RowBottonDefaultStyle) {
            
            UIButton* botton = _items[_Selectedtag];
            [botton setTitleColor:ColorRGB(100, 100, 100) forState:UIControlStateNormal];
            
            _Selectedtag = tag;
            botton = _items[_Selectedtag];
            [botton setTitleColor:SelectedbgView.backgroundColor forState:UIControlStateNormal];
            SelectedbgView.frame = CGRectMake(botton.frame.origin.x+_spacing, self.frame.size.height - 2, botton.frame.size.width, 4);
            
        }else if(_style == RowBottonStyle2){
            
            UIColor * color = ColorRGB(100, 100, 100);
            UIButton* botton = _items[_Selectedtag];
            [botton setTitleColor:color forState:UIControlStateNormal];
            botton.layer.borderColor = (__bridge CGColorRef _Nullable)(color);
            
            _Selectedtag = tag;
            botton = _items[_Selectedtag];
            botton.userInteractionEnabled = YES;
            [botton.layer setCornerRadius:3.0];
            botton.layer.borderWidth = 1.0f;
            color = ColorRGB(252, 142, 175);
            botton.layer.borderColor =color.CGColor;
            [botton setTitleColor:color forState:UIControlStateNormal];
        }
        
        
    }];
}



//大小改变时重新计算坐标
- (void )layoutSubviews{
    _mainscr.frame = self.bounds;
    
    //NSLog(@"%f",self.frame.size.width);

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
            btn.frame = CGRectMake(Potomac+_spacing, 4, w+Surplusf, mainHeight-8);
            Potomac+=(w+Surplusf+_spacing);
        }
        
        
    }else{
        
        
        _mainscr.scrollEnabled = YES;
        _mainscr.contentSize = CGSizeMake(minWidth, mainHeight);
        
        CGFloat Potomac = 0;
        for (int i = 0; i < _items.count; i++) {
            UIButton* btn = _items[i];
            CGFloat w = [self widthWithFont:_font String:btn.titleLabel.text];
            btn.frame = CGRectMake(Potomac+_spacing, 4, w, mainHeight-8);
            Potomac+=(w+_spacing);
        }
    
    }
    [self setSelectedBotton:_Selectedtag];
}








//返回总长最小需要多宽
-(CGFloat)getRowMinWidth{
    CGFloat minWidth  = _spacing;
    for (int i = 0; i < _titles.count; i++) {
        minWidth += [self widthWithFont:_font String:_titles[i]];
        minWidth += _spacing;
    }
    return minWidth;
}

//返回最小需要多宽
-(CGFloat)widthWithFont:(UIFont*)font String:(NSString*)str{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    return rect.size.width+20;
}


@end
