//
//  KORecommendSpecialColumnCell.h
//  KOFM
//
//  Created by Korune on 2019/1/3.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KOTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class KORecommendSpecialColumnItem;

@interface KORecommendSpecialColumnCell : KOTableViewCell

@property (nonatomic, strong) KORecommendSpecialColumnItem *item;

@end

NS_ASSUME_NONNULL_END
