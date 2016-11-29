//
//  UIStyleMacro.h
//  bilibili fake
//
//  Created by cxh on 16/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//


//风格背景色
//风格前景色
//彩色按钮颜色


//TabBar 顶部主标题  VC主标题   风格背景色


//一般单元格（视频标题，up主名字，房间名字）的标题文字 黑色
//一般单元格的详情文字  灰色


//分区单元格 和 下面TabBar按钮文字      灰色
//其他按钮单元格文字 黑色






#define UIStyleName [UIStyleMacro share].styleName

#define UIStyleBackgroundColor [UIStyleMacro share].backgroundColor
#define UIStyleForegroundColor [UIStyleMacro share].foregroundColor
#define UIStyleColourBtnColor [UIStyleMacro share].colourBtnColor
#define UIStylePromptLabelColor [UIStyleMacro share].promptLabelColor
#define UIStyleJCTagCellBg [UIStyleMacro share].JCTagCellBg

//不知道怎么起名了
#define UIStyleFont_2   [UIFont systemFontOfSize:10]
#define UIStyleFont_1   [UIFont systemFontOfSize:13]
#define UIStyleDefaultFont [UIFont systemFontOfSize:15]
#define UIStyleFont1   [UIFont systemFontOfSize:18]
#define UIStyleFont2   [UIFont systemFontOfSize:20]


#import <Foundation/Foundation.h>

@interface UIStyleMacro : NSObject

+(instancetype)share;


//改风格
+(void)changeWithStyleName:(NSString*)styleName;
+(void)changeWithIndex:(NSInteger)index;


//风格名字
@property(nonatomic,strong,readonly)NSString* styleName;
//风格名字列表
@property(nonatomic,strong,readonly)NSArray<NSDictionary *>* uiStyleDataArr;


//前景色
@property(nonatomic,strong,readonly)UIColor* foregroundColor;
//背景色
@property(nonatomic,strong,readonly)UIColor* backgroundColor;
//彩色按钮颜色
@property(nonatomic,strong,readonly)UIColor* colourBtnColor;
//提示标签颜色
@property(nonatomic,strong,readonly)UIColor* promptLabelColor;
//提示标签颜色
@property(nonatomic,strong,readonly)UIColor* JCTagCellBg;
//风格label的颜色（主题设置里面）
@property(nonatomic,strong,readonly)UIColor* styleNameLabelColor;
//搜索结果tabbar颜色
@property(nonatomic,strong,readonly)NSArray<NSNumber *>* SearchResultTabBarTintColor;
@property(nonatomic,strong,readonly)NSArray<NSNumber *>* SearchResultTabBarCelTintColor;
////字体就不想设置了，
////一般单元格的标题
//@property(nonatomic,strong)UIFont* cellTitleFont;
////一般单元格的描述
//@property(nonatomic,strong)UIFont* cellDesFont;
////顶部标题
//@property(nonatomic,strong)UIFont* topTitleFont;


@end
