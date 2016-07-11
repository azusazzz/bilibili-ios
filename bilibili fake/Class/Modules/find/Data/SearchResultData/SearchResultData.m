//
//  SearchResultData.m
//  bilibili fake
//
//  Created by cxh on 16/7/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultData.h"
typedef void(^GetPageinfoSuccessBlock)(NSMutableDictionary* pageinfo_dic);


#define Search_URL @"http://api.bilibili.com/search?actionKey=appkey&appkey=27eb53fc9058f8c3&main_ver=v3"
@interface SearchResultData (){
    
    GetPageinfoSuccessBlock getPageinfo_successBlock;
    

    /**
     *  关键字
     */
    NSString *_keyword;
    
    
    
    /**
     *  页面（眉头）信息
     */
    NSMutableDictionary* pageinfo_dic;
    /**
     * tid映射表
     */
    NSMutableDictionary* tidList_dic;
    
    
    /**
     *  所有视频 搜索结果，一共7个大字典  totalrank：总排名  click：点击 dm：弹幕 scores:评论 pubdate：日期 stow：收藏
     *  7个字典下面分别有12个数组存放对应tid的视频数组
     */
    NSMutableDictionary* videoSearchResultData_dic;
    /**
     *  番剧 搜索结果
     */
    NSMutableArray* bangumiSearchResultData_arr;
    /**
     *  专题 搜索结果
     */
    NSMutableArray* specialSearchResultData_arr;
    /**
     *  up主 搜索结果
     */
    NSMutableArray* upuserSearchResultData_arr;
    
}


@end

@implementation SearchResultData
//--------------------------------------------------------------
#pragma SearchResultData
//--------------------------------------------------------------


//初始化
-(instancetype)initWithKeyword:(NSString*)keyword{
    self = [super init];
    if (self) {
        [self setKeyword:keyword];
    }
    return self;
}
//设置keywork 获取数据前必须要设置关键字
-(void)setKeyword:(NSString*)keyword{
    _keyword = keyword;
    //重新初始化所有数据
    pageinfo_dic = nil;
    tidList_dic = [[NSMutableDictionary alloc] init];
    
    videoSearchResultData_dic = [[NSMutableDictionary alloc] init];
    for (NSString* str1 in @[@"totalrank",@"click",@"dm",@"scores",@"pubdate",@"stow"]) {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [videoSearchResultData_dic setObject:dic forKey:str1];
    }
    
    bangumiSearchResultData_arr = [[NSMutableArray alloc] init];
    specialSearchResultData_arr = [[NSMutableArray alloc] init];
    upuserSearchResultData_arr = [[NSMutableArray alloc] init];
}




//获取页眉信息
-(void)getPageinfo:(void(^)(NSMutableDictionary* pageinfo_dic))successBlock{
    if (_keyword.length == 0) return;
    pageinfo_dic = nil;
    
    getPageinfo_successBlock = successBlock;
}



/**
 * 获取up主,番剧,信息
 *
 *  @param search_type  搜索类型
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
-(void)getNonVideoSearchResultData_arr:(NSString* )search_type Success:(void(^)(NSMutableArray* SearchResultData_arr))successBlock Error:(void(^)(NSError* error))errorBlock{
     if (_keyword.length == 0) return;
    
    
    NSMutableArray* outARR;
    if([search_type isEqualToString:@"bangumi"] ){
       outARR = bangumiSearchResultData_arr ;
    }else if([search_type isEqualToString:@"topic"] ){
       outARR = specialSearchResultData_arr;
    }else if([search_type isEqualToString:@"upuser"] ){
       outARR =   upuserSearchResultData_arr;
    }
    
    if (outARR.count > 0) {
        successBlock(outARR);
    }
    
    
    NSString* urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=%@&page=1&pagesize=30",Search_URL,_keyword,search_type];
    NSLog(@"%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
   
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            
            NSDictionary* rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[rawData objectForKey:@"code"] integerValue] == -3) {
                //bilibili总是喜欢出这个bug
                [self getNonVideoSearchResultData_arr:search_type Success:successBlock Error:errorBlock];
            }else{
                
                
                if(pageinfo_dic == NULL){
                    pageinfo_dic = [rawData objectForKey:@"top_tlist"];
                   if(getPageinfo_successBlock) getPageinfo_successBlock(pageinfo_dic);
                
                }
                
                //赋值数组
                NSMutableArray* SearchResultData_arr = [rawData objectForKey:@"result"];
                
                if([search_type isEqualToString:@"bangumi"] ){
                     bangumiSearchResultData_arr =  SearchResultData_arr;
                }else if([search_type isEqualToString:@"topic"] ){
                    specialSearchResultData_arr =  SearchResultData_arr;
                }else if([search_type isEqualToString:@"upuser"] ){
                    upuserSearchResultData_arr =  SearchResultData_arr;
                }
                successBlock(SearchResultData_arr);
            }
        }else{
            errorBlock(error);
        }
    }]resume];
}





//--------------------------------------------------------------
#pragma SearchRecords
//--------------------------------------------------------------
+(NSString*)getSearchRecordsPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    NSString* path = [cachesPath stringByAppendingPathComponent:@"SearchRecords.plist"];
    NSFileManager* mgr = [NSFileManager defaultManager];
    if([mgr fileExistsAtPath:path] == NO)//查看文件是否存在
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"data":@[]}];
        [dic writeToFile:path atomically:YES];
    }
    return path;
}


+(void)addSearchRecords:(NSString*)str{
    if (str.length == 0)   return;
    
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[SearchResultData getSearchRecordsPath]];
    NSMutableArray* outArr = [dic objectForKey:@"data"];
    
    if (outArr == nil)  outArr = [[NSMutableArray alloc] init];
    
    if (outArr.count>=5) return;
    
    for (int i = 0; i < outArr.count; i++) {
        if([str isEqualToString:outArr[i]])[outArr removeObjectAtIndex:i];
    }
    
    [outArr insertObject:str atIndex:0];
    [SearchResultData setSearchRecords:outArr];
}


+(void)setSearchRecords:(NSMutableArray*)arr{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[SearchResultData getSearchRecordsPath]];
    [dic setObject:arr forKey:@"data"];
    [dic writeToFile:[SearchResultData getSearchRecordsPath] atomically:YES];
}




@end


