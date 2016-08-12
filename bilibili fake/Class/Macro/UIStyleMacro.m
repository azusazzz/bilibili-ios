//
//  UIStyleMacro.m
//  bilibili fake
//
//  Created by cxh on 16/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "UIStyleMacro.h"
#import "UIColor+String.h"

static UIStyleMacro* UIStyle;

@implementation UIStyleMacro

+(instancetype)share{
    if (UIStyle == NULL) {
        UIStyle = [[UIStyleMacro alloc] init];
    }
    return UIStyle;
}


+(void)changeWithStyleName:(NSString*)styleName{
    if (UIStyle == NULL) {
        UIStyle = [[UIStyleMacro alloc] init];
    }
    [UIStyle changeWithStyleName:styleName];
}



-(NSString*)getPath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"UIStyleMacro.plist"];
    return path;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _styleNameArr = @[@"少女粉",@"简洁白"];
        
        //读取本地的
        NSFileManager* mgr = [NSFileManager defaultManager];
        if([mgr fileExistsAtPath:[self getPath]] == YES){//查看文件是否存在
            NSDictionary* UIStyleData = [NSDictionary dictionaryWithContentsOfFile:[self getPath]];
            //风格名字
            _styleName = [UIStyleData objectForKey:@"styleName"];
        }
        
        [self changeWithStyleName:_styleName];
    }
    return self;
}


-(void)changeWithStyleName:(NSString*)styleName{

    if([styleName isEqualToString:@"简洁白"]){
        //风格名字
        _styleName = @"简洁白";
        //颜色
        _backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        _foregroundColor = [UIColor colorWithRed:27/255.0 green:27/255.0 blue:27/255.0 alpha:1];
        _colourBtnColor = [UIColor colorWithRed:253/255.0 green:129/255.0 blue:164/255.0 alpha:1];
        _promptLabelColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        _JCTagCellBg = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    }else{
        //风格名字
        _styleName = @"少女粉";
        //颜色
        _backgroundColor = [UIColor colorWithRed:253/255.0 green:129/255.0 blue:164/255.0 alpha:1];
        _foregroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        _colourBtnColor = [UIColor colorWithRed:253/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        _promptLabelColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        _JCTagCellBg = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.1];
    }
    
    NSDictionary* UIStyleData = @{@"styleName":_styleName};
    [UIStyleData writeToFile:[self getPath] atomically:YES];
}



@end
