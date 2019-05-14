//
//  KOMainModuleAPI.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOMainModuleAPI : NSObject

+ (UIViewController *)rootTabBarController;

+ (void)addChildVC:(UIViewController *)vc
   normalImageName:(NSString *)normalImageName
 selectedImageName:(NSString *)selectedImageName
isRequiredNavController:(BOOL)isRequired;

@end

NS_ASSUME_NONNULL_END
