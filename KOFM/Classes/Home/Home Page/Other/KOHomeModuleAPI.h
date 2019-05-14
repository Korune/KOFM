//
//  KOHomeModuleAPI.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOHomeModuleAPI : NSObject

@property (nonatomic, weak, readonly) UIViewController *homeVC;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
