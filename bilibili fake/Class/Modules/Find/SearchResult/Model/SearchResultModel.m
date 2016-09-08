//
//  SearchResultModel.m
//  bilibili fake
//
//  Created by cxh on 16/9/8.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel
-(void)addHistoryWord:(NSString*)keyword{
    if (keyword.length == 0)return;
    
    NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"SearchHistory.plist"];
    
    NSMutableArray* arr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (arr == nil)arr = [[NSMutableArray alloc] init];
    
    [arr removeObject:keyword];
    [arr insertObject:keyword atIndex:0];
    if (arr.count == 6) [arr removeLastObject];
    
    [arr writeToFile:path atomically:YES];
}
@end
