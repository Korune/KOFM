//
//  UIImage+KOExtension.m
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "UIImage+KOExtension.h"

@implementation UIImage (KOExtension)

+ (UIImage *)ko_originalImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)ko_loadMainBundleImageWithFullName:(NSString *)fullName
{
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fullName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (image == nil) {
        image = [UIImage imageNamed:fullName];
    }
    return image;
    
    // !!!: 下面代码并不能自动获取 @2x、@3x 的图片
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:fullName ofType:nil];
}

+ (UIImage*)ko_ImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
