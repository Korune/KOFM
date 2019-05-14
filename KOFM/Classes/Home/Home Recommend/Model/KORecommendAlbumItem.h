//
//  KOEditorRecommendAlbumItem.h
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KORecommendAlbumItem : NSObject

@property (nonatomic, copy)  NSString *ID;
@property (nonatomic, copy)  NSString *albumId;
@property (nonatomic, copy)  NSString *uid;
@property (nonatomic, copy)  NSString *intro;
@property (nonatomic, copy)  NSString *nickname;
@property (nonatomic, copy)  NSString *albumCoverUrl290;
@property (nonatomic, copy)  NSString *coverSmall;
@property (nonatomic, copy)  NSString *coverMiddle;
@property (nonatomic, copy)  NSString *coverLarge;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy)  NSString *tags;
@property (nonatomic, copy)  NSString *tracks;
@property (nonatomic, copy)  NSString *playsCounts;
@property (nonatomic, copy)  NSString *isFinished;
@property (nonatomic, copy)  NSString *serialState;
@property (nonatomic, copy)  NSString *trackId;
@property (nonatomic, copy)  NSString *trackTitle;
@property (nonatomic, copy)  NSString *isPaid;
@property (nonatomic, copy)  NSString *commentsCount;
@property (nonatomic, copy)  NSString *priceTypeId;
@property (nonatomic, copy)  NSString *priceTypeEnum;

@end

NS_ASSUME_NONNULL_END
