//
//  UIColor+KOExtension.h
//  KOFM
//
//  Created by Korune on 2018/12/10.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KOExtension)

+ (UIColor *)ko_colorWithHexString:(NSString *)color;

/// 从十六进制字符串获取颜色，color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)ko_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
