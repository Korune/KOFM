//
//  KOMainModuleAPI.m
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOMainModuleAPI.h"
#import "KOTabBarController.h"

@implementation KOMainModuleAPI

+ (UIViewController *)rootTabBarController
{
    return [KOTabBarController sharedInstance];
}

+ (void)addChildVC:(UIViewController *)vc
   normalImageName:(NSString *)normalImageName
 selectedImageName:(NSString *)selectedImageName
isRequiredNavController:(BOOL)isRequired
{
    [[KOTabBarController sharedInstance] addChildVC:vc
                                    normalImageName:normalImageName
                                  selectedImageName:selectedImageName
                            isRequiredNavController:isRequired];
}

@end
