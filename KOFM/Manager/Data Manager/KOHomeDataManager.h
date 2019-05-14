//
//  KOHomeDataManager.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KOHomeTabItem;

@interface KOHomeDataManager : NSObject

+ (void)getHomeTabs:(void (^)(NSArray<KOHomeTabItem *> * _Nullable tabs))resultBlock;

@end

NS_ASSUME_NONNULL_END
