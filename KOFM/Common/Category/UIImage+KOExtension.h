//
//  UIImage+KOExtension.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KOExtension)

/// 加载 ImageRenderingModeAlwaysOriginal 的图片
+ (UIImage *)ko_originalImageWithName:(NSString *)name;

/**
 * 加载项目中直接放在项目中的图片，非 Assets.xcassets 里的图片。传入文件全名比如：image.png，可以自动识别 image@2x.png、image@3x.png 的图片。
 * @param fullName 文件全名，包含后缀名，不用包含 @2x、@3x，例如：image.png。
 * @return UIImage 对象
 */
+ (UIImage *)ko_loadMainBundleImageWithFullName:(NSString *)fullName;

/// 颜色转图片
+ (UIImage*)ko_ImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
