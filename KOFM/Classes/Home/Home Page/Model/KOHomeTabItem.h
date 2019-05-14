//
//  KOHomeTabItem.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOHomeTabItem : NSObject

@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *isDefaultSelected;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
