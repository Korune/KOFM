//
//  KOBannerView.h
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOBannerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class KOBannerView;

@protocol KOBannerViewDelegate <NSObject>

- (void )koBannerView:(KOBannerView *)bannerView didSelectItemWithObject:(id)object;
/// 滚动到了 indexPath 位置。(注意：第一次显示第一个 cell 时，不会调用此回调)
- (void )koBannerView:(KOBannerView *)bannerView didScrollToItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface KOBannerView : UIView

@property (nonatomic, weak) id<KOBannerViewDelegate> delegate;
/// 自动滚动时间间隔，默认3s
@property (nonatomic) CGFloat scrollDuration;
@property (nonatomic, copy) NSArray<id <KOBannerProtocol>> *photos;

@end

NS_ASSUME_NONNULL_END
