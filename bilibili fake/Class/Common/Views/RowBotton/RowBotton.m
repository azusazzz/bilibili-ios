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
    
    NSInteger Selectedtag;
    UIView* SelectedbgView;
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
        self.backgroundColor = [UIColor whiteColor];
        Selectedtag = 0;
        
        _mainscr = [[UIScrollView alloc] init];
         _mainscr.contentSize = self.frame.size;
        _mainscr.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:_mainscr];
        [self setTitles:titles];
        
        if (style == RowBottonDefaultStyle) {
            SelectedbgView = [[UIView alloc] init];
            SelectedbgView.backgroundColor = ColorRGB(220, 130, 150);
            [_mainscr addSubview:SelectedbgView];
            [self setSelectedBotton:Selectedtag];
        }

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
            btn.frame = CGRectMake(Potomac, 4, w+Surplusf, mainHeight-8);
            Potomac+=(w+Surplusf);
        }
        
        
    }else{
        
        
        _mainscr.scrollEnabled = YES;
        _mainscr.contentSize = CGSizeMake(minWidth, mainHeight);
        
        CGFloat Potomac = 0;
        for (int i = 0; i < _items.count; i++) {
            UIButton* btn = _items[i];
            CGFloat w = [self widthWithFont:_font String:btn.titleLabel.text];
            btn.frame = CGRectMake(Potomac, 4, w, mainHeight-8);
            Potomac+=w;
        }
    
    }
    [self setSelectedBotton:Selectedtag];
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
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [_mainscr addSubview:btn];
        [_items addObject:btn];
    }
    
}


-(void)btnAction:(id)sender{
    UIButton* botton = sender;
    _block(botton.tag);
    [self setSelectedBotton:botton.tag];
}


-(void)setSelectedBotton:(NSInteger)tag{
    
    [UIView animateWithDuration:0.2 animations:^{

        
        if (_style == RowBottonDefaultStyle) {
            
            UIButton* botton = _items[Selectedtag];
            [botton setTitleColor:ColorRGB(100, 100, 100) forState:UIControlStateNormal];
            
            Selectedtag = tag;
            botton = _items[Selectedtag];
            [botton setTitleColor:SelectedbgView.backgroundColor forState:UIControlStateNormal];
            SelectedbgView.frame = CGRectMake(botton.frame.origin.x, self.frame.size.height - 2, botton.frame.size.width, 2);
            
        }else if(_style == RowBottonStyle2){
            
            UIColor * color = ColorRGB(100, 100, 100);
            UIButton* botton = _items[Selectedtag];
            [botton setTitleColor:color forState:UIControlStateNormal];
            botton.layer.borderColor = (__bridge CGColorRef _Nullable)(color);
            
            Selectedtag = tag;
            botton = _items[Selectedtag];
            botton.userInteractionEnabled = YES;
            [botton.layer setCornerRadius:3.0];
            botton.layer.borderWidth = 1.0f;
            color = ColorRGB(220, 130, 150);
            botton.layer.borderColor =color.CGColor;
            [botton setTitleColor:color forState:UIControlStateNormal];
        }
       

    }];
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
    return rect.size.width+20;
}


@end
