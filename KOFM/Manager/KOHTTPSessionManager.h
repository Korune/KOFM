//
//  KOHTTPSessionManager.h
//  KOFM
//
//  Created by Korune on 2018/12/7.
//  Copyright © 2018 Korune. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KORequestType) {
    KORequestTypeGet,
    KORequestTypePost,
};

@interface KOHTTPSessionManager : NSObject

@property (nonatomic) KORequestType requestType;

- (void)requestType:(KORequestType)requestType
          urlString:(NSString *)urlString
             params:(nullable NSDictionary *)params
        resultBlock:(void (^)(id _Nullable responseObject, NSError * _Nullable error))resultBlock;

@end

NS_ASSUME_NONNULL_END
