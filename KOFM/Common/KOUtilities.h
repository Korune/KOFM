//
//  KOUtilities.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+KOExtension.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const kKOBaseURL;
UIKIT_EXTERN NSString *const kKOLiveURL;
/// cell 标准间距
UIKIT_EXTERN const CGFloat kKOCellStandardMargin;

#define KO_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define KO_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define KO_FONT(F) [UIFont fontWithName:@"PingFangSC-Regular" size:F]
#define KO_FONT_BOLD(F) [UIFont fontWithName:@"PingFangSC-Semibold" size:F]

#define KOHexColor_AAAAAA [UIColor ko_colorWithHexString:@"0xAAAAAA"]

@interface KOUtilities : NSObject

@end

NS_ASSUME_NONNULL_END
