//
//  KOHomeRecommendAPI.h
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOHomeRecommendAPI : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak, readonly) UIViewController *recommendVC;

@end

NS_ASSUME_NONNULL_END
