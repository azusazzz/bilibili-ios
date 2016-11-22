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
}
+(instancetype)share{
    @synchronized (self) {
        if (!shareProjecUpdate) {
            shareProjecUpdate = [[self alloc] init];
        }
    }
    return shareProjecUpdate;
}

-(void)update{
    NSString* updateAddressPath = [[NSBundle mainBundle] pathForResource:@"updateAddress" ofType:@"json"];
    NSDictionary* updateAddressDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:updateAddressPath] options:NSJSONReadingMutableLeaves error:nil];
    _entity = [UpdateAddressEntity mj_objectWithKeyValues:updateAddressDic];

    
    // NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:UpdateAddressURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary* dataDic =  [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            newEntity = [UpdateAddressEntity mj_objectWithKeyValues:dataDic];
            NSLog(@"newEntity:%@,Entity:%@",newEntity.version,_entity.version);
            if ([newEntity.version compare:_entity.version options:NSNumericSearch]== NSOrderedDescending) {
                NSLog(@"更新：%@",newEntity.path);
                newEntity.path = @"https://raw.githubusercontent.com/Learning-Software-Development/bilibili-fake/master/bilibili%20fake/Resources/";
                newEntity.files = @[@"lua/UpdateTest.lua"];
                [self download];
            }
        }
    }] resume];
    
 

    
    
}

-(void)download{
    for (int i = 0; i < newEntity.files.count; ++i) {
        NSURL *url = [NSURL URLWithString:[newEntity.path stringByAppendingString:newEntity.files[i]]];
        NSString* savepath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        savepath = [savepath stringByAppendingPathComponent:@"Resources"];
        NSLog(@"%@",savepath);
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSString* path = [savepath stringByAppendingPathComponent:newEntity.files[i]];
                [[NSFileManager defaultManager] createDirectoryAtPath:[path stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
                [data writeToFile:path atomically:YES];
            }
        }] resume];
    }

}
@end
