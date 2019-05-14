//
//  KOHomeDataManager.m
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHomeDataManager.h"
#import "KOHomeTabItem.h"
#import "KOHTTPSessionManager.h"
#import "KOUtilities.h"
#import <MJExtension.h>

@interface KOHomeDataManager ()

@property (nonatomic, strong) KOHTTPSessionManager *sessionManager;

@end

@implementation KOHomeDataManager

- (KOHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[KOHTTPSessionManager alloc] init];
    }
    return _sessionManager;
}

+ (void)getHomeTabs:(void (^)(NSArray<KOHomeTabItem *> *tabs))resultBlock
{
    KOHomeDataManager *dataManager = [[KOHomeDataManager alloc] init];
    NSString *urlString = [kKOBaseURL stringByAppendingPathComponent:@"mobile/discovery/v1/tabs"];
    NSDictionary *params = @{
                            @"device": @"iPhone"
                            };
    [dataManager.sessionManager requestType:KORequestTypeGet urlString:urlString params:params resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        NSArray *menuTabs = [KOHomeTabItem mj_objectArrayWithKeyValuesArray:responseObject[@"tabs"][@"list"]];
        resultBlock(menuTabs);
    }];
}

@end

