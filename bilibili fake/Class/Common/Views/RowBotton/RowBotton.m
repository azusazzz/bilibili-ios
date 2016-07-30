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
@interface RowBotton ()
@property(nonatomic, copy, readonly)BLOCK block;
@end
@implementation RowBotton{
    NSMutableArray<UIButton *> *_items;
    NSMutableArray<NSString *> *_titles;

    RowBottonStyle _style;
    
    UIScrollView* _mainscr;
    UIFont* _font;
    
    UIView* SelectedbgView;
    NSInteger _spacing;
    
    UIColor* NormalColor;//正常颜色
    UIColor* SelectedColor;//选中颜色
}


- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles  Block:(void(^)(NSInteger btnTag))block{
  return   [self initWithTitles:titles Style:RowBottonDefaultStyle Block:block];
}



- (instancetype)initWithTitles:(NSMutableArray<NSString *> *)titles Style:(RowBottonStyle)style  Block:(void(^)(NSInteger btnTag))block{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:14];
        _block = [block copy];
        _style = style;
        _spacing = 0;
//        self.backgroundColor = [UIColor whiteColor];
        _Selectedtag = -1;
        NormalColor = ColorRGB(100, 100, 100);
        SelectedColor = ColorRGB(252, 142, 175);
        
        
        _mainscr = [[UIScrollView alloc] init];
         _mainscr.contentSize = self.frame.size;
        _mainscr.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:_mainscr];
        [self setTitles:titles];
        
        if (style == RowBottonDefaultStyle) {
            SelectedbgView = [[UIView alloc] init];
            SelectedbgView.backgroundColor = SelectedColor;
            [_mainscr addSubview:SelectedbgView];
            
        }
//        [self setSelectedBotton:_Selectedtag];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}


#pragma ----------------------------------
//按钮点击事件处理
-(void)btnAction:(id)sender{
    UIButton* botton = sender;
    [self setSelectedBotton:botton.tag];
    if(_block) _block(botton.tag);
    
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
    //_Selectedtag = -1;
    [self setSelectedBotton:_Selectedtag animation:NO];
}


#pragma --------常用函数--------------------
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


#pragma ----------------------------------

//获取选中的按钮
-(UIButton*)getSelected_button{
    return _items[_Selectedtag];
}


//设置点击回调
- (void)setSelecteBlock:(void(^)(NSInteger btnTag))block{
    _block = [block copy];
}


//设置间距
- (void)setSpacing:(NSInteger)spacing{
    _spacing = spacing;
    [self layoutSubviews];
}


//设置字体
- (void)setFont:(UIFont*)font{
    _font = font;
    [self setTitles:_titles];
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
        [btn.titleLabel setFont:_font];
        [btn setTitleColor:NormalColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [_mainscr addSubview:btn];
        [_items addObject:btn];
    }
    _Selectedtag = -1;
    if (_Selectedtag+1 > titles.count) {
        _Selectedtag = -1;
    }
    [self layoutSubviews];
}


//设置选择的按钮
-(void)setSelectedBotton:(NSInteger)tag{
    [self setSelectedBotton:tag animation:YES];
}

-(void)setSelectedBotton:(NSInteger)tag animation:(BOOL)animation{
    CGFloat time = 0.2;
    if (_Selectedtag == -1) {
        time = 0.0;
        _Selectedtag = 0;
        tag = 0;
    }
    
    if (animation == NO) {
        time = 0.0;
    }
    
    [UIView animateWithDuration:time animations:^{
        
        
        if (_style == RowBottonDefaultStyle) {
            
            UIButton* botton = _items[_Selectedtag];
            [botton setTitleColor:NormalColor forState:UIControlStateNormal];
            
            _Selectedtag = tag;
            botton = _items[_Selectedtag];
            [botton setTitleColor:SelectedbgView.backgroundColor forState:UIControlStateNormal];
            SelectedbgView.frame = CGRectMake(botton.frame.origin.x-_spacing/2, self.frame.size.height - 2, botton.frame.size.width+_spacing, 4);
            
        }else if(_style == RowBottonStyle2){
            
            UIColor * color = NormalColor;
            UIButton* botton = _items[_Selectedtag];
            [botton setTitleColor:color forState:UIControlStateNormal];
            botton.layer.borderColor = (__bridge CGColorRef _Nullable)(color);
            
            _Selectedtag = tag;
            botton = _items[_Selectedtag];
            botton.userInteractionEnabled = YES;
            [botton.layer setCornerRadius:3.0];
            botton.layer.borderWidth = 1.0f;
            color = SelectedColor;
            botton.layer.borderColor =color.CGColor;
            [botton setTitleColor:color forState:UIControlStateNormal];
        }
        
        
    }];
}

//设置滚动位置
- (void)setContentOffset:(CGFloat)contentOffset {
    
    if (contentOffset < 0 || contentOffset > 1 ||_style == RowBottonStyle2) {
        return;
    }
    
}
#pragma ----------------------------------












#pragma ----------------------------------






@end
