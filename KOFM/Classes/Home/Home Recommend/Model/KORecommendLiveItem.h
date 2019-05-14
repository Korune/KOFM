//
//  KORecommendLiveItem.h
//  KOFM
//
//  Created by Korune on 2018/12/25.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KOBannerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KORecommendLiveItem : NSObject<KOBannerProtocol>

@property (nonatomic, copy)  NSString *chatId;
@property (nonatomic, copy, getter=bannerImgURLString)  NSString *coverPath;
@property (nonatomic, copy)  NSString *endTs;
@property (nonatomic, copy)  NSString *id;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy)  NSString *onlineCount;
@property (nonatomic, copy)  NSString *playCount;
@property (nonatomic, copy)  NSString *scheduleId;
@property (nonatomic, copy)  NSString *shortDescription;
@property (nonatomic, copy)  NSString *startTs;
@property (nonatomic, copy)  NSString *status;

@end

NS_ASSUME_NONNULL_END
