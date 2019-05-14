//
//  KORecommendGroupItem.h
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KORecommendGroupType) {
    /// 一行三列
    KORecommendGroupType13,
    /// 广告轮播
    KORecommendGroupTypeAD,
    /// N 行一列
    KORecommendGroupTypeN1
};

@interface KORecommendGroupItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger sortID;
@property (nonatomic) KORecommendGroupType groupType;

@end

NS_ASSUME_NONNULL_END
