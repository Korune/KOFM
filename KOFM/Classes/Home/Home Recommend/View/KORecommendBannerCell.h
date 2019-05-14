//
//  KORecommendBannerCell.h
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KOTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class KORecommendBannerCell;
@protocol KORecommendBannerCellDelegate <NSObject>

- (void)koRecommendBannerCell:(KORecommendBannerCell *)cell didSelectItemWithObject:(id)object;

@end

@class KORecommendGroupItem;

@interface KORecommendBannerCell : KOTableViewCell

@property (nonatomic, weak) id<KORecommendBannerCellDelegate> delegate;
@property (nonatomic, strong) KORecommendGroupItem *group;

@end

NS_ASSUME_NONNULL_END
