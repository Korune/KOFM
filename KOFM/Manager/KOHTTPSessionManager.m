//
//  KOHTTPSessionManager.m
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHTTPSessionManager.h"
#import <AFNetworking.h>

@interface KOHTTPSessionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation KOHTTPSessionManager

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        NSMutableSet *set = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [set addObject:@"text/plain"];
        [set addObject:@"text/html"];
        _sessionManager.responseSerializer.acceptableContentTypes = [set copy];
    }
    return _sessionManager;
}

- (void)requestType:(KORequestType)requestType
          urlString:(NSString *)urlString
             params:(nullable NSDictionary *)params
        resultBlock:(void (^)(id responseObject, NSError *error))resultBlock
{
    void(^successBlock)(NSURLSessionDataTask * task, id  responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        resultBlock(responseObject, nil);
    };
    
    void(^failureBlock)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask * task, NSError *error) {
        resultBlock(nil, error);
    };
    
    if (self.requestType == KORequestTypeGet) {
        [self.sessionManager GET:urlString parameters:params progress:nil success:successBlock failure:failureBlock];
    } else if (self.requestType == KORequestTypePost) {
        [self.sessionManager POST:urlString parameters:params progress:nil success:successBlock failure:failureBlock];
    }
}

@end
