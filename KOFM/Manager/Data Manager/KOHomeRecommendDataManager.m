//
//  KOHomeRecommendDataManager.m
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHomeRecommendDataManager.h"
#import "KORecommendGroupItem.h"
#import "KOUtilities.h"
#import "KOHTTPSessionManager.h"
#import <MJExtension.h>
#import "KORecommendAlbumItem.h"
#import "KORecommendLiveItem.h"
#import "KORecommendSpecialColumnItem.h"

static NSString const* kDeviceIPhone = @"iPhone";
static NSString const* kAppVersion = @"5.4.21";

@interface KOHomeRecommendDataManager ()

@property (nonatomic, strong) KOHTTPSessionManager *sessionManager;

@end

@implementation KOHomeRecommendDataManager

- (KOHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[KOHTTPSessionManager alloc] init];
    }
    return _sessionManager;
}

+ (void)getEditorRecommendAlbums:(void(^)(KORecommendGroupItem *group, NSError *error))resultBlock
{
    KOHomeRecommendDataManager *dataManager = [[KOHomeRecommendDataManager alloc] init];
    NSString *urlString = [kKOBaseURL stringByAppendingPathComponent:@"mobile/discovery/v4/recommends"];
    NSDictionary *params = @{
                            @"channel": @"ios-b1",
                            @"device": kDeviceIPhone,
                            @"includeActivity": @(YES),                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": kAppVersion
                            };
    
    [dataManager.sessionManager requestType:KORequestTypeGet urlString:urlString params:params resultBlock:^(id  _Nullable responseObject, NSError * _Nullable error) {
        
        [KORecommendGroupItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : [KORecommendAlbumItem class]
                     };
        }];
        NSDictionary *dict = responseObject[@"editorRecommendAlbums"];
        KORecommendGroupItem *group = [KORecommendGroupItem mj_objectWithKeyValues:dict];
        return resultBlock(group, error);
    }];
}

+ (void)getLiveMessage:(void (^)(KORecommendGroupItem * _Nullable, NSError * _Nullable))resultBlock
{
    KOHomeRecommendDataManager *dataManager = [[KOHomeRecommendDataManager alloc] init];
    NSString *urlString = [kKOLiveURL stringByAppendingPathComponent:@"live-activity-web/v3/activity/recommend"];
    
    [dataManager.sessionManager requestType:KORequestTypeGet urlString:urlString params:nil resultBlock:^(id _Nullable responseObject, NSError * _Nullable error) {
        
        NSArray *liveItems = [KORecommendLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        KORecommendGroupItem *group = [[KORecommendGroupItem alloc] init];
        group.title = @"现场直播";
        group.list = liveItems;
        
        return resultBlock(group, error);
    }];
}

+ (void)getCityAlbums:(void(^)(KORecommendGroupItem * _Nullable group, NSError * _Nullable error))resultBlock
{
    KOHomeRecommendDataManager *dataManager = [[KOHomeRecommendDataManager alloc] init];
    NSString *urlString = [kKOBaseURL stringByAppendingPathComponent:@"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *params = @{
                             @"code": @"43_440000_4401",
                             @"device": kDeviceIPhone,
                             @"version": kAppVersion
                             };
    
    [dataManager.sessionManager requestType:KORequestTypeGet urlString:urlString params:params resultBlock:^(id  _Nullable responseObject, NSError * _Nullable error) {
        [KORecommendGroupItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : [KORecommendAlbumItem class]
                     };
        }];
        NSDictionary *dict = responseObject[@"cityColumn"];
        KORecommendGroupItem *group = [KORecommendGroupItem mj_objectWithKeyValues:dict];
        return resultBlock(group, error);
    }];
}

+ (void)getSpecialColumn:(void(^)(KORecommendGroupItem * _Nullable group, NSError * _Nullable error))resultBlock
{
    KOHomeRecommendDataManager *dataManager = [[KOHomeRecommendDataManager alloc] init];
    NSString *urlString = [kKOBaseURL stringByAppendingPathComponent:@"mobile/discovery/v4/recommends"];
    NSDictionary *params = @{
                             @"channel": @"ios-b1",
                             @"includeActivity": @(YES),
                             @"includeSpecial": @(YES),
                             @"scale": @2,
                             @"device": kDeviceIPhone,
                             @"version": kAppVersion
                             };
    
    [dataManager.sessionManager requestType:KORequestTypeGet urlString:urlString params:params resultBlock:^(id  _Nullable responseObject, NSError * _Nullable error) {
        [KORecommendGroupItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : [KORecommendSpecialColumnItem class]
                     };
        }];
        NSDictionary *dict = responseObject[@"specialColumn"];
        KORecommendGroupItem *group = [KORecommendGroupItem mj_objectWithKeyValues:dict];
        return resultBlock(group, error);
    }];
}

+ (void)getHotRecommendAlbums:(void(^)(NSArray<KORecommendGroupItem *> * _Nullable groups, NSError * _Nullable error))resultBlock
{
    KOHomeRecommendDataManager *dataManager = [[KOHomeRecommendDataManager alloc] init];
    NSString *urlString = [kKOBaseURL stringByAppendingPathComponent:@"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *params = @{
                            @"code": @"43_440000_4401",
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };
    [dataManager.sessionManager requestType:KORequestTypeGet urlString:urlString params:params resultBlock:^(id  _Nullable responseObject, NSError * _Nullable error) {
        [KORecommendGroupItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : [KORecommendAlbumItem class]
                     };
        }];
        NSArray *groups = [KORecommendGroupItem mj_objectArrayWithKeyValuesArray:responseObject[@"hotRecommends"][@"list"]];
        [groups enumerateObjectsUsingBlock:^(KORecommendGroupItem * _Nonnull group, NSUInteger idx, BOOL * _Nonnull stop) {
            group.sortID = 10 + idx;
            group.groupType = KORecommendGroupType13;
        }];
        return resultBlock(groups, error);
    }];
    
}

@end
