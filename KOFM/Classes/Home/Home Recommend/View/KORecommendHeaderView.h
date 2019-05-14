//
//  KORecommendHeaderView.h
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KORecommendHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
