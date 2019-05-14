//
//  KOTabBarController.m
//  KOFM
//
//  Created by Korune on 2018/12/6.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOTabBarController.h"
#import "KONavigationController.h"

#import "UIImage+KOExtension.h"

@implementation KOTabBarController

static KOTabBarController *tabVC = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabVC = [[self alloc] init];
    });
    return tabVC;
}

- (void)addChildVC:(UIViewController *)vc
   normalImageName:(NSString *)normalImageName
 selectedImageName:(NSString *)selectedImageName
isRequiredNavController: (BOOL)isRequired
{
    if (isRequired) {
        KONavigationController *nav = [[KONavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:nil
                                      image:[UIImage ko_originalImageWithName:normalImageName]
                              selectedImage:[UIImage ko_originalImageWithName:selectedImageName]];
        [self addChildViewController:nav];
    } else {
        [self addChildViewController:vc];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
