//
//  ESRequest.m
//  ESRequest
//
//  Created by 翟泉 on 16/5/7.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "ESRequest.h"
#import <CommonCrypto/CommonDigest.h>


@implementation ESRequest

- (instancetype)initWithAPIType:(APIType)type; {
    if (self = [super init]) {
        ESAPIConfig * config = [[ESAPIConfigManager sharedInstance] APIConfigForType:type];
        NSAssert(config, ([NSString stringWithFormat:@"找不到API类型为%ld的配置", type]));
        _type = type;
        _URLString = [config URLString];
        _method = [config method];
        _cacheTimeoutInterval = [config cacheTimeoutInterval];
    }
    return self;
}

+ (instancetype)RequestWithAPIType:(APIType)type parameters:(id)parameters delegate:(id<ESRequestDelegate>)delegate; {
    ESRequest *request = [[ESRequest alloc] initWithAPIType:type];
    request.parameters = parameters;
    request.delegate = delegate;
    return request;
}


#pragma mark start / stop

- (void)start; {
    if ([self readCache]) {
        [self completion];
    }
    else {
        [self willStartRequest];
        _executing = YES;
        [[ESRequestHandler sharedInstance] sendRequest:self];
    }
}

- (void)stop; {
    self.delegate = NULL;
    self.completionBlock = NULL;
    self.successCompletionBlock = NULL;
    self.failureCompletionBlock = NULL;
}

#pragma mark Response

- (NSInteger)responseStatusCode; {
    return [[_responseObject objectForKey:@"status"] integerValue];
}

#pragma mark - ESRequestHandlerDelegate

- (void)requestHandlerResponseObject:(id)responseObject error:(NSError *)error; {
    _executing = NO;
    _responseObject = responseObject;
    _error = error;
    
    
    if (responseObject) {
        [self storeCache];
    }
    
    
    [self completion];
}


#pragma mark Private-Cache

- (BOOL)readCache; {
    NSAssert([self.URLString length], @"Error: 请求URL不能为空");
    if (![self willReadCache]) {
        return NO;
    }
    BOOL isTimeout;
    id cachedJSONObject = [[ESRequestCache sharedInstance] cachedJSONObjectForRequest:self IsTimeout:&isTimeout];
    if (cachedJSONObject && !isTimeout) {
        _responseObject = cachedJSONObject;
        NSLog(@"缓存");
        return YES;
    }
    else {
        return NO;
    }
}

- (void)storeCache; {
    if (!_responseObject) {
        return;
    }
    if (![self willStoreCache]) {
        return;
    }
    [[ESRequestCache sharedInstance] storeCachedJSONObjectForRequest:self];
}




#pragma mark other

- (NSString *)identifier; {
    const char *cStr = [[NSString stringWithFormat:@"%@_%@", self.URLString, self.parameters] UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return [output copy];
}


#pragma mark nextPage

- (BOOL)analysisNextKeyPath:(NSDictionary *)dict Array:(NSMutableArray *)array; {
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        if ([key isEqualToString:@"next"]) {
            return YES;
        }
        if ([value isKindOfClass:[NSDictionary class]]) {
            [array addObject:key];
            BOOL result = [self analysisNextKeyPath:value Array:array];
            if (result) {
                return  result;
            }
        }
    }
    [array removeLastObject];
    return NO;
}

- (NSArray<NSString *> *)nextKeyPath; {
    if (self.responseObject == nil) {
        return NULL;
    }
    if (NULL == _nextKeyPath) {
        NSMutableArray *array = [NSMutableArray array];
        BOOL result = [self analysisNextKeyPath:self.responseObject Array:array];
        if (result) {
            _nextKeyPath = [NSArray arrayWithArray:array];
        }
        else {
            _nextKeyPath = [NSArray array];
        }
    }
    return _nextKeyPath;
}

- (BOOL)next; {
    if (self.responseObject == nil) {
        return NO;
    }
    else if ([self.nextKeyPath count] == 0) {
        return NO;
    }
    NSDictionary *dict = self.responseObject;
    for (NSString *key in self.nextKeyPath) {
        dict = [dict objectForKey:key];
    }
    return [[dict objectForKey:@"next"] boolValue];
}

- (NSInteger)index; {
    if (self.responseObject == nil) {
        return -1;
    }
    else if ([self.nextKeyPath count] == 0) {
        return -1;
    }
    NSDictionary *dict = self.responseObject;
    for (NSString *key in self.nextKeyPath) {
        dict = [dict objectForKey:key];
    }
    return [[dict objectForKey:@"index"] integerValue];
}

- (NSInteger)pageSize; {
    if (self.responseObject == nil) {
        return -1;
    }
    else if ([self.nextKeyPath count] == 0) {
        return -1;
    }
    NSDictionary *dict = self.responseObject;
    for (NSString *key in self.nextKeyPath) {
        dict = [dict objectForKey:key];
    }
    return [[dict objectForKey:@"pageSize"] integerValue];
}

- (void)nextPage; {
    if (!self.next) {
        return;
    }
    if (![self.parameters isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)self.parameters];
    [mutableDict setValue:@(self.index+1) forKey:@"p"];
    self.parameters = [mutableDict copy];
    [self start];
}

#pragma mark --------

- (void)dynamicURLStringWithCallback:(void (^)(NSString *, id))callback;
{
    if (![self.parameters isKindOfClass:[NSDictionary class]]) {
        callback? callback(self.URLString, self.parameters) : NULL;
        return;
    }
    
    NSDictionary *parameters = (NSDictionary *)self.parameters;
    if ([parameters count] == 0) {
        return;
    }
    
    NSMutableArray<NSString *> *parameterNames = [NSMutableArray array];
    NSRange range = NSMakeRange(0, self.URLString.length);
    NSInteger start = -1;
    
    while (YES) {
        range = [self.URLString rangeOfString:@"%%" options:NSCaseInsensitiveSearch range:range];
        if (range.length > 0) {
            if (start == -1) {
                start = range.location + range.length;
            }
            else {
                [parameterNames addObject:[self.URLString substringWithRange:NSMakeRange(start, range.location - start)]];
                start = -1;
            }
            range.location = range.location + range.length;
            range.length = self.URLString.length - range.location;
        }
        else {
            break;
        }
    }
    
    if (parameterNames.count == 0) {
        callback? callback(self.URLString, self.parameters) : NULL;
        return;
    }
    
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *URLString = self.URLString;
    
    for (NSString *key in parameters.allKeys) {
        for (NSString *name in parameterNames) {
            if ([key isEqualToString:name]) {
                URLString = [URLString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%%%%%@%%%%", name] withString:[NSString stringWithFormat:@"%@", [parameters objectForKey:key]]];
                [mutableParameters removeObjectForKey:key];
            }
        }
    }
    
    callback? callback(URLString, (mutableParameters.count? mutableParameters : NULL) ) : NULL;
}

- (void)willStartRequest; {
    if ([self.delegate respondsToSelector:@selector(willStartRequest:)]) {
        [self.delegate willStartRequest:self];
    }
}

- (BOOL)willReadCache; {
    if (self.dataFromNetwork) {
        return NO;
    }
    else if (self.cacheTimeoutInterval <= 0) {
        return NO;
    }
    return YES;
}

- (void)completion; {
    if ([self.delegate respondsToSelector:@selector(requestCompletion:)]) {
        [self.delegate requestCompletion:self];
    }
    self.completionBlock? self.completionBlock(self) : NULL;
    if (!_error) {
        [self successCompletion];
    }
    else {
        [self failureCompletion];
    }
}

- (void)successCompletion; {
    self.successCompletionBlock? self.successCompletionBlock(self) : NULL;
}

- (void)failureCompletion; {
    _responseMsg = [self.error.userInfo objectForKey:NSLocalizedDescriptionKey];
    
    if ([[self.error.userInfo objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"The request timed out."]) {
        _responseMsg = @"请求超时";
    }
    
    self.failureCompletionBlock? self.failureCompletionBlock(self) : NULL;
}

- (BOOL)willStoreCache; {
    if (self.cacheTimeoutInterval <= 0) {
        return NO;
    }
    else if (self.responseStatusCode == 1) {
        return YES;
    }
    else {
        return NO;
    }
}


@end
