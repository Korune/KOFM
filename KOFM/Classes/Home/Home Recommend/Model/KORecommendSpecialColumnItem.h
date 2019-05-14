//
//  KORecommendSpecialColumnItem.h
//  KOFM
//
//  Created by Korune on 2019/1/3.
//  Copyright © 2019 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KORecommendSpecialColumnItem : NSObject

@property (nonatomic, assign)  NSInteger columnType;
@property (nonatomic, assign)  NSInteger specialId;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy)  NSString *subtitle;
@property (nonatomic, copy)  NSString *footnote;
@property (nonatomic, copy)  NSString *coverPath;
@property (nonatomic, copy)  NSString *contentType;

@end

NS_ASSUME_NONNULL_END
