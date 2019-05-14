//
//  KOEditorRecommendAlbumItem.m
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KORecommendAlbumItem.h"
#import <MJExtension.h>

@implementation KORecommendAlbumItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

@end
