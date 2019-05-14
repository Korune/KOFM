//
//  KOHomeModuleAPI.m
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHomeModuleAPI.h"
#import "KOHomeController.h"

@interface KOHomeModuleAPI ()

@property (nonatomic, weak) UIViewController *homeVC;

@end

@implementation KOHomeModuleAPI


static KOHomeModuleAPI *sharedInstance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (UIViewController *)homeVC
{
    return [[KOHomeController alloc] init];
}

@end
