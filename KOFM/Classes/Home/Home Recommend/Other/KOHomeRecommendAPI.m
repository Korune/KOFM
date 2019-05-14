//
//  KOHomeRecommendAPI.m
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHomeRecommendAPI.h"
#import "KOHomeRecommendController.h"

@implementation KOHomeRecommendAPI

static KOHomeRecommendAPI *api = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[self alloc] init];
    });
    return api;
}

- (UIViewController *)recommendVC
{
    return [[KOHomeRecommendController alloc] init];
}

@end
