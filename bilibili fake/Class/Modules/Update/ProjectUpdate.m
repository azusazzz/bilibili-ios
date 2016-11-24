//
//  ProjectUpdate.m
//  bilibili fake
//
//  Created by cxh on 16/11/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ProjectUpdate.h"
#define UpdateAddressURL @"https://raw.githubusercontent.com/Learning-Software-Development/bilibili-fake/master/bilibili%20fake/Resources/updateAddress.json"

static ProjectUpdate* shareProjecUpdate;

@implementation ProjectUpdate{
    UpdateAddressEntity* newEntity;
    NSData* newUpdateAddressData;
}
+(instancetype)share{
    @synchronized (self) {
        if (!shareProjecUpdate) {
            shareProjecUpdate = [[self alloc] init];
        }
    }
    return shareProjecUpdate;
}

-(NSString*)update{
    NSString* savepath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    savepath = [savepath stringByAppendingPathComponent:@"Resources"];
    NSString*  cachesupdateAddressPath  = [savepath stringByAppendingPathComponent:@"updateAddress.json"];
    
    NSString*  updateAddressPath= [[NSBundle mainBundle] pathForResource:@"updateAddress" ofType:@"json"];;
    NSDictionary* updateAddressDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:updateAddressPath] options:NSJSONReadingMutableLeaves error:nil];
    _entity = [UpdateAddressEntity mj_objectWithKeyValues:updateAddressDic];
    //NSLog(@"%@",cachesupdateAddressPath);
    if([[NSFileManager defaultManager] fileExistsAtPath:cachesupdateAddressPath] == YES){
    
        updateAddressDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:cachesupdateAddressPath] options:NSJSONReadingMutableLeaves error:nil];
        UpdateAddressEntity *cachesEntity = [UpdateAddressEntity mj_objectWithKeyValues:updateAddressDic];
        //比较项目文件与缓存文件的版本号。
        if ([_entity.version compare:cachesEntity.version options:NSNumericSearch]== NSOrderedDescending) {
            //删除本地文件
            [[NSFileManager defaultManager] removeItemAtPath:savepath error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:savepath withIntermediateDirectories:YES attributes:nil error:nil];
        }else{
            _entity = cachesEntity;
        }
        
    }


    
    // NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:UpdateAddressURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            newUpdateAddressData = data;
            NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary* dataDic =  [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            newEntity = [UpdateAddressEntity mj_objectWithKeyValues:dataDic];
            NSLog(@"newEntity:%@,Entity:%@",newEntity.version,_entity.version);
            //比较本地文件与网络文件的版本号。
            if ([newEntity.version compare:_entity.version options:NSNumericSearch]== NSOrderedDescending) {
                NSLog(@"更新：%@",newEntity.path);
//                newEntity.path = @"https://raw.githubusercontent.com/Learning-Software-Development/bilibili-fake/master/bilibili%20fake/Resources/";
//                newEntity.files =[[NSMutableArray alloc] initWithArray: @[@"lua/UpdateTest.lua",@"lua/StartView/Init.lua"]];
                [self download];
            }
        }
    }] resume];
    
    
    
   
    NSString* initPath = [savepath stringByAppendingPathComponent:@"lua/Init.lua"];
    if([[NSFileManager defaultManager] fileExistsAtPath:initPath] == YES){
        return initPath;
    }
    return [[NSBundle mainBundle] pathForResource:@"Init" ofType:@"lua"];
    
}

-(void)download{
    NSString* savepath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    savepath = [savepath stringByAppendingPathComponent:@"Resources"];
    if(newEntity.files.count){
        NSURL *url = [NSURL URLWithString:[newEntity.path stringByAppendingString:[newEntity.files lastObject]]];
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSString* path = [savepath stringByAppendingPathComponent:[newEntity.files lastObject]];
                [newEntity.files removeLastObject];
                [[NSFileManager defaultManager] createDirectoryAtPath:[path stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
                [data writeToFile:path atomically:YES];
                [self download];
            }
        }] resume];
    }else{
         NSString* path = [savepath stringByAppendingPathComponent:@"updateAddress.json"];
        [newUpdateAddressData writeToFile:path atomically:YES];
    }
}

@end
