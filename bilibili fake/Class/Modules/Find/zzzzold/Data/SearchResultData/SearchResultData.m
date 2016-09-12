//
//  SearchResultData.m
//  bilibili fake
//
//  Created by cxh on 16/7/11.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "SearchResultData.h"
//typedef void(^GetPageinfoSuccessBlock)(NSMutableDictionary* pageinfo_dic);


#define Search_URL @"http://api.bilibili.com/search?actionKey=appkey&appkey=27eb53fc9058f8c3&main_ver=v3"
@interface SearchResultData (){
    
    //GetPageinfoSuccessBlock getPageinfo_successBlock;
    

    /**
     *  关键字
     */
    NSString *_keyword;
    NSMutableDictionary* orderDIC;//筛选映射表
    NSMutableDictionary* tidsDIC;//tid映射表
    NSMutableDictionary* nowPageCount;//当前防止重复请求页数
    
    /**
     *  页面（眉头）信息
     */
    NSMutableDictionary* pageinfo_dic;
    /**
     * tid映射表
     */
    NSMutableArray* tidList_arr;
    
    
    /**
     *  所有视频 搜索结果，一共7个大字典  totalrank：总排名  click：点击 dm：弹幕 scores:评论 pubdate：日期 stow：收藏
     *  7个字典下面分别有12个数组存放对应tid的视频数组
     */
    NSMutableDictionary* videoSearchResultData_dic;
    //如果有番剧首页的三个
    NSMutableArray* homeBangumiSearchResultData_arr;
    
    
    /**
     *  番剧 搜索结果
     */
    NSMutableArray* bangumiSearchResultData_arr;
    NSInteger bangumiMAXCount;//最大值
    /**
     *  专题 搜索结果
     */
    NSMutableArray* specialSearchResultData_arr;
    NSInteger specialMAXCount;//最大值
    /**
     *  up主 搜索结果
     */
    NSMutableArray* upuserSearchResultData_arr;
    NSInteger upuserMAXCount;//最大值
    
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
        //视频映射表
        orderDIC = [[NSMutableDictionary alloc] initWithDictionary:@{@"综合":@"totalrank"
                                                                     ,@"点击":@"click"
                                                                     ,@"弹幕":@"dm"
                                                                     ,@"评论":@"scores"
                                                                     ,@"日期":@"pubdate"
                                                                     ,@"收藏":@"stow"}];
        
        tidsDIC = [[NSMutableDictionary alloc] initWithDictionary:@{@"全部":@"0"
                                                                    ,@"番剧":@"13"
                                                                    ,@"动画":@"1"
                                                                    ,@"音乐":@"3"
                                                                    ,@"舞蹈":@"129"
                                                                    ,@"游戏":@"4"
                                                                    ,@"科技":@"36"
                                                                    ,@"生活":@"160"
                                                                    ,@"鬼畜":@"119"}];
    }
    return self;
}

//设置keywork 获取数据前必须要设置关键字
-(void)setKeyword:(NSString*)keyword{
    _keyword = keyword;
    //重新初始化所有数据
    pageinfo_dic = nil;
    tidList_arr = [[NSMutableArray alloc] init];
    
    videoSearchResultData_dic = [[NSMutableDictionary alloc] init];
    
    bangumiSearchResultData_arr = [[NSMutableArray alloc] init];
    specialSearchResultData_arr = [[NSMutableArray alloc] init];
    upuserSearchResultData_arr = [[NSMutableArray alloc] init];
    homeBangumiSearchResultData_arr = [[NSMutableArray alloc] init];
    nowPageCount = [[NSMutableDictionary alloc] init];
}




//获取页眉信息
-(void)getPageinfo:(void(^)(NSInteger bangumiCount,NSInteger specialCount,NSInteger upuserCount))successBlock{
    if (_keyword.length == 0) return;
    pageinfo_dic = nil;
    //请求数据
    NSString* urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=%@&page=1&pagesize=1",Search_URL,_keyword,@"all"];
    NSLog(@"%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            NSDictionary* rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[rawData objectForKey:@"code"] integerValue] == -3) {
                //bilibili总是喜欢出这个bug
                [weakSelf getPageinfo:successBlock];
            }else if([[rawData objectForKey:@"code"] integerValue] == 0){
                pageinfo_dic = [rawData objectForKey:@"top_tlist"];
                tidList_arr = [rawData objectForKey:@"sub_tlist"];
                
                
                bangumiMAXCount = [[pageinfo_dic objectForKey:@"bangumi"] integerValue];
                            
                specialMAXCount = [[pageinfo_dic objectForKey:@"special"] integerValue];
                specialMAXCount += [[pageinfo_dic objectForKey:@"tvplay"] integerValue];//专题包括电视剧
               
                upuserMAXCount = [[pageinfo_dic objectForKey:@"upuser"] integerValue];
    
                successBlock(bangumiMAXCount,specialMAXCount,upuserMAXCount);
            }
                
        }
        [session invalidateAndCancel];
    }] resume];
    //getPageinfo_successBlock = successBlock;
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
    //查看是否没有结果
    
    //查看是否本地已经有请求过的数据了
    BOOL isReturn = NO;
    if([search_type isEqualToString:@"bangumi"] ){
        if(bangumiSearchResultData_arr.count)successBlock(bangumiSearchResultData_arr);
        if(bangumiMAXCount==0)isReturn=YES;
    }else if([search_type isEqualToString:@"special"] ){
        if(specialSearchResultData_arr.count)successBlock(specialSearchResultData_arr);
        if(specialMAXCount==0)isReturn=YES;
        
    }else if([search_type isEqualToString:@"upuser"] ){
        if(upuserSearchResultData_arr.count)successBlock(upuserSearchResultData_arr);
        if(upuserMAXCount==0)isReturn=YES;
    }
    
    if (isReturn) {
        successBlock(nil);
        return;
    }
    
    //请求数据
    NSString* urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=%@&page=1&pagesize=30",Search_URL,_keyword,search_type];
    NSLog(@"%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            
            NSDictionary* rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[rawData objectForKey:@"code"] integerValue] == -3) {
                //bilibili总是喜欢出这个bug
                [weakSelf getNonVideoSearchResultData_arr:search_type Success:successBlock Error:errorBlock];
            }else if([[rawData objectForKey:@"code"] integerValue] == 0){
                
                //赋值数组
                NSMutableArray* SearchResultData_arr = [rawData objectForKey:@"result"];
                
                if([search_type isEqualToString:@"bangumi"] ){
                     bangumiSearchResultData_arr =  SearchResultData_arr;
                }else if([search_type isEqualToString:@"special"] ){
                    specialSearchResultData_arr =  SearchResultData_arr;
                }else if([search_type isEqualToString:@"upuser"] ){
                    upuserSearchResultData_arr =  SearchResultData_arr;
                }
                successBlock(SearchResultData_arr);
            }
        }else{
            errorBlock(error);
        }
        [session invalidateAndCancel];
    }]resume];
}


/**
 *  获取更多的up主,番剧,信息
 *
 *  @param search_type  搜索类型
 *  @param successBlock 成功回调（回调所有的结果）
 */
-(void)getMoreNonVideoSearchResultData_arr:(NSString* )search_type Success:(void(^)(NSMutableArray* UpuserSearchResultData_arr))successBlock{
    if (_keyword.length == 0) return;
    
    //查看是否本地已经有请求过的数据了
    NSMutableArray* outARR;
    
    if([search_type isEqualToString:@"bangumi"] ){
       if(bangumiSearchResultData_arr.count>=bangumiMAXCount)return;
        outARR = bangumiSearchResultData_arr;
    }else if([search_type isEqualToString:@"special"] ){
       if(specialSearchResultData_arr.count>=specialMAXCount)return;
        outARR = specialSearchResultData_arr;
    }else if([search_type isEqualToString:@"upuser"] ){
       if(upuserSearchResultData_arr.count>=upuserMAXCount)return;
        outARR = upuserSearchResultData_arr;
    }

    //防止重复请求添加
    NSString* key_str = search_type;
    NSInteger Pagecount = [[nowPageCount objectForKey:key_str] integerValue];
    NSInteger count = outARR.count/30+1;
    if (Pagecount >= count) return;
    [nowPageCount setObject:@(count) forKey:key_str];
    
    
    
    //请求数据
    NSString* urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=%@&page=%0.0f&pagesize=30",Search_URL,_keyword,search_type,(outARR.count/30.0 +1)];
    NSLog(@"%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            
            NSDictionary* rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[rawData objectForKey:@"code"] integerValue] == -3) {
                //bilibili总是喜欢出这个bug
                [nowPageCount setObject:@(count-1) forKey:key_str];
                [weakSelf getMoreNonVideoSearchResultData_arr:search_type Success:successBlock];
            }else if([[rawData objectForKey:@"code"] integerValue] == 0){
                
                //赋值数组
                NSMutableArray* SearchResultData_arr = [rawData objectForKey:@"result"];
                
                if([search_type isEqualToString:@"bangumi"] ){
                    [bangumiSearchResultData_arr addObjectsFromArray:SearchResultData_arr];
                     successBlock(bangumiSearchResultData_arr);
                }else if([search_type isEqualToString:@"special"] ){
                    [specialSearchResultData_arr addObjectsFromArray:SearchResultData_arr];
                     successBlock(specialSearchResultData_arr);
                }else if([search_type isEqualToString:@"upuser"] ){
                    [upuserSearchResultData_arr addObjectsFromArray:SearchResultData_arr];
                     successBlock(upuserSearchResultData_arr);
                }
               
            }
        }
        [session invalidateAndCancel];
    }]resume];
    
}
/**
 *  获取视频搜索结果
 *
 *  @param order        排序方式
 *  @param name         tid对应的名字
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
-(void)getVideoSearchResultData_arr:(NSString* )order Tid_name:(NSString*)name Success:(void(^)(NSMutableArray* SearchResultData_arr, NSMutableArray* bangumiSearchResultData_arr))successBlock Error:(void(^)(NSError* error))errorBlock{
    if (_keyword.length == 0) {
         successBlock(nil,nil);
        return;
    }
    NSString* order_value_str = [orderDIC objectForKey:order];
    NSString* tid_value_str = [tidsDIC objectForKey:name];
    //要获取的排序字典
    NSMutableDictionary* order_dic = [videoSearchResultData_dic objectForKey:order_value_str];
    if (order_dic == nil){
        order_dic= [[NSMutableDictionary alloc]init];
        [videoSearchResultData_dic setObject:order_dic forKey:order_value_str];
    }
    //对应tid的数组
    NSMutableArray* tid_arr = [order_dic objectForKey:tid_value_str];
    if(tid_arr == nil){
        tid_arr = [[NSMutableArray alloc] init];
        [order_dic setObject:tid_arr forKey:tid_value_str];
    }
    
    if (tid_arr.count>0) {
        //如果是综合
        if ([tid_value_str integerValue] == 0) {
            successBlock(tid_arr, homeBangumiSearchResultData_arr);
        }else{
            successBlock(tid_arr,[[NSMutableArray alloc] init]);
        }
        return;
    }
    
    
    //请求数据
    NSString* urlstr = @"";
    if ([tid_value_str integerValue] == 0) {
         urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=all&page=1&pagesize=30&order=%@",Search_URL,_keyword,order_value_str];
    }else{
         urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=video&page=1&pagesize=30&order=%@&tids=%@",Search_URL,_keyword,order_value_str,tid_value_str];
    }

    
    
    NSLog(@"%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            
            NSDictionary* rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[rawData objectForKey:@"code"] integerValue] == -3) {
                //bilibili总是喜欢出这个bug
                [weakSelf getVideoSearchResultData_arr:order Tid_name:name Success:successBlock Error:errorBlock];
                
            }else if([[rawData objectForKey:@"code"] integerValue] == 0){
                
                //赋值数组
                 NSMutableArray* SearchResultData_arr;
                if ([tid_value_str integerValue] == 0) {
                    homeBangumiSearchResultData_arr = [[rawData objectForKey:@"result"] objectForKey:@"bangumi"];
                    SearchResultData_arr = [[rawData objectForKey:@"result"] objectForKey:@"video"];
                }else{
                    SearchResultData_arr = [rawData objectForKey:@"result"];
                }
               
                NSMutableDictionary* order_dic = [videoSearchResultData_dic objectForKey:order_value_str];
                [order_dic setObject:SearchResultData_arr forKey:tid_value_str];
                [videoSearchResultData_dic setObject:order_dic forKey:order_value_str];
                //如果是首页综合把番剧分隔开

                successBlock(SearchResultData_arr,homeBangumiSearchResultData_arr);
                
                
            }
        }else{
            errorBlock(error);
        }
        [session invalidateAndCancel];
    }]resume];
}
/**
 *  获取视频搜索结果
 *
 *  @param order        排序方式
 *  @param name         tid对应的名字
 *  @param successBlock 成功回调
 */
-(void)getMoreVideoSearchResultData_arr:(NSString* )order Tid_name:(NSString*)name Success:(void(^)(NSMutableArray* SearchResultData_arr))successBlock{

    if (_keyword.length == 0) return;
    NSString* order_value_str = [orderDIC objectForKey:order];
    NSString* tid_value_str = [tidsDIC objectForKey:name];
    
    NSMutableDictionary* order_dic = [videoSearchResultData_dic objectForKey:order_value_str];//要获取的排序字典
    NSMutableArray* tid_arr = [order_dic objectForKey:tid_value_str]; //对应tid的数组
    //看看是否已经娶到最大值
   
        NSInteger maxCount = 0;
    if ([tid_value_str integerValue] == 0) {
        maxCount = [[pageinfo_dic objectForKey:@"video"] integerValue];
    }else{
        for(NSDictionary* dic in tidList_arr) {
            NSInteger tid = [[dic objectForKey:@"tid"] integerValue];
            if (tid  == [tid_value_str integerValue]) {
                maxCount = [[dic objectForKey:@"count"] integerValue];
                break;
            }
        }
    }
    
    if(tid_arr.count >= maxCount){
        successBlock(tid_arr);return;
    }
    
    //防止重复请求添加
    NSString* key_str = [order stringByAppendingString:name];
    NSInteger Pagecount = [[nowPageCount objectForKey:key_str] integerValue];
    NSInteger count = tid_arr.count/30+1;
    if (Pagecount >= count) return;
    [nowPageCount setObject:@(count) forKey:key_str];
    
    
    //请求数据
    NSString* urlstr = @"";
    if ([tid_value_str integerValue] == 0) {
        urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=all&page=%lu&pagesize=30&order=%@",Search_URL,_keyword,count,order_value_str];
    }else{
        urlstr = [NSString stringWithFormat:@"%@&keyword=%@&search_type=video&page=%lu&pagesize=30&order=%@&tids=%@",Search_URL,_keyword,count,order_value_str,tid_value_str];
    }
    
    
    
    NSLog(@"%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            
            NSDictionary* rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[rawData objectForKey:@"code"] integerValue] == -3) {
                //bilibili总是喜欢出这个bug
                [nowPageCount setObject:@(count-1) forKey:key_str];
                [weakSelf getMoreVideoSearchResultData_arr:order Tid_name:name Success:successBlock];
               
            }else if([[rawData objectForKey:@"code"] integerValue] == 0){
                
                //赋值数组
                NSMutableArray* SearchResultData_arr;
                if ([tid_value_str integerValue] == 0) {
                    //homeBangumiSearchResultData_arr = [[rawData objectForKey:@"result"] objectForKey:@"bangumi"];
                    SearchResultData_arr = [[rawData objectForKey:@"result"] objectForKey:@"video"];
                }else{
                    SearchResultData_arr = [rawData objectForKey:@"result"];
                }
                
                NSMutableDictionary* order_dic = [videoSearchResultData_dic objectForKey:order_value_str];//要获取的排序字典
                NSMutableArray* tid_arr = [order_dic objectForKey:tid_value_str]; //对应tid的数组
                [tid_arr addObjectsFromArray:SearchResultData_arr];
                
                [order_dic setObject:tid_arr forKey:tid_value_str];
                //如果是首页综合把番剧分隔开
                
                successBlock(tid_arr);
                
                
            }
        }else{
           [nowPageCount setObject:@(count-1) forKey:key_str];
        }
        [session invalidateAndCancel];
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


