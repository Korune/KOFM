//
//  KOHomeRecommendDataManager.h
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KORecommendGroupItem;
@interface KOHomeRecommendDataManager : NSObject

/// 获取小编推荐数据
+ (void)getEditorRecommendAlbums:(void(^)(KORecommendGroupItem * _Nullable group, NSError * _Nullable error))resultBlock;

/// 获取发现模块的"现场直播"
+ (void)getLiveMessage:(void(^)(KORecommendGroupItem * _Nullable group, NSError * _Nullable error))resultBlock;

+ (void)getCityAlbums:(void(^)(KORecommendGroupItem * _Nullable group, NSError * _Nullable error))resultBlock;

/// 获取发现模块的”精品听单“
+ (void)getSpecialColumn:(void(^)(KORecommendGroupItem * _Nullable group, NSError * _Nullable error))resultBlock;

/// "热门推荐-听其他"
+ (void)getHotRecommendAlbums:(void(^)(NSArray<KORecommendGroupItem *> * _Nullable groups, NSError * _Nullable error))resultBlock;

@end

NS_ASSUME_NONNULL_END
