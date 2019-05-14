//
//  KORecommendCollectionView.h
//  KOFM
//
//  Created by Korune on 2018/12/21.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KORecommendCollectionView : UICollectionView

/// 当前对应的 tableViewCell 的 indexPath，用于 self 对应的模型
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

NS_ASSUME_NONNULL_END
