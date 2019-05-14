//
//  KORecommendCell.h
//  KOFM
//
//  Created by Korune on 2018/12/10.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface KORecommendCell : KOTableViewCell

- (void)setCollectionViewDataSourceAndDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate
                                  forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
