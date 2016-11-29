//
//  ResponseSerializer.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/8/10.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ResponseSerializer.h"
#import <XMLDictionary.h>

@implementation ResponseSerializer

+ (instancetype)serializer {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/xml", nil];
    return self;
}

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    
    id responseObject = nil;
    NSError *serializationError = nil;
    
    
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length > 0 && !isSpace) {
        if ([response.MIMEType isEqualToString:@"application/json"] ||
            [response.MIMEType isEqualToString:@"text/json"]) {
            
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            if (serializationError) {
                NSMutableString *JSONString = [NSMutableString stringWithUTF8String:data.bytes];
                if ([JSONString hasPrefix:@"seasonListCallback("]) {
                    [JSONString deleteCharactersInRange:NSMakeRange(0, @"seasonListCallback(".length)];
                    [JSONString deleteCharactersInRange:NSMakeRange(JSONString.length-2, @");".length)];
                    data = [NSData dataWithBytes:JSONString.UTF8String length:[JSONString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
                    serializationError = NULL;
                    responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
                }
            }
        }
        else if ([response.MIMEType isEqualToString:@"text/xml"]) {
            responseObject = [NSDictionary dictionaryWithXMLData:data];
        }
        else if ([response.MIMEType isEqualToString:@"text/javascript"]) {
            NSMutableString *JSONString = [NSMutableString stringWithUTF8String:data.bytes];
            if ([JSONString hasPrefix:@"seasonListCallback("]) {
                [JSONString deleteCharactersInRange:NSMakeRange(0, @"seasonListCallback(".length)];
                [JSONString deleteCharactersInRange:NSMakeRange(JSONString.length-2, @");".length)];
                data = [NSData dataWithBytes:JSONString.UTF8String length:[JSONString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
                serializationError = NULL;
                responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            }
        }
    }
    else {
        return nil;
    }
    
    
    if (error && serializationError) {
        NSMutableDictionary *mutableUserInfo = [serializationError.userInfo mutableCopy];
        mutableUserInfo[NSUnderlyingErrorKey] = *error;
        *error = [[NSError alloc] initWithDomain:serializationError.domain code:serializationError.code userInfo:mutableUserInfo];
    }
    
    return responseObject;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] init];
}

@end
