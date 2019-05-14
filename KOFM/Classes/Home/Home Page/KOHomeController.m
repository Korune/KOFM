//
//  KOHomeController.m
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHomeController.h"
#import "KOHomeDataManager.h"
#import "KOHomeRecommendAPI.h"

@interface KOHomeController ()

@end

@implementation KOHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
    [self loadHomeTabsData];
}

- (void)loadHomeTabsData
{
    [KOHomeDataManager getHomeTabs:^(NSArray<KOHomeTabItem *> * _Nullable tabs) {
        NSArray *childVCs = @[[KOHomeRecommendAPI sharedInstance].recommendVC];
        [self setUpWithSegModels:nil andChildVCs:childVCs];
    }];
}

- (void)setUpWithSegModels:(NSArray *)segModels andChildVCs:(NSArray <UIViewController *>*)childVCs
{
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
    }
    
}


@end
