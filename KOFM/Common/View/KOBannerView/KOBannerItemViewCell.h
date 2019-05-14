//
//  KOBannerItemViewCell.h
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOBannerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KOBannerItemViewCell : UICollectionViewCell

@property (nonatomic, strong) id<KOBannerProtocol> item;

@end

NS_ASSUME_NONNULL_END
