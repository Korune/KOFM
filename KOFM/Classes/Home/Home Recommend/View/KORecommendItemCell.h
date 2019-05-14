//
//  KORecommendItemCell.h
//  KOFM
//
//  Created by Korune on 2018/12/20.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KORecommendAlbumItem;

@interface KORecommendItemCell : UICollectionViewCell

@property (nonatomic, strong) KORecommendAlbumItem *recommendAlbumItem;

+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
