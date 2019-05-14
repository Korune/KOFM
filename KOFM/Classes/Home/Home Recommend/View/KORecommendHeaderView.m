//
//  KORecommendHeaderView.m
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KORecommendHeaderView.h"
#import <Masonry.h>
#import "UIImage+KOExtension.h"
#import "KOUtilities.h"

@interface KORecommendHeaderView ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation KORecommendHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupChildViews];
    }
    return self;
}

static NSString *s_headerViewID = @"KORecommendHeaderView";
+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    KORecommendHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:s_headerViewID];
    if (headerView == nil) {
        headerView = [[KORecommendHeaderView alloc] initWithReuseIdentifier:s_headerViewID];
    }
    return headerView;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setupChildViews
{
    UIView *titleContentView = [[UIView alloc] init];
    [self.contentView addSubview:titleContentView];
    [titleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage ko_loadMainBundleImageWithFullName:@"liveRadioCellPoint.png"];
    [titleContentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(10);
        make.left.mas_equalTo(kKOCellStandardMargin);
        make.centerY.mas_equalTo(titleContentView.mas_centerY);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = KO_FONT(14);
    [titleContentView addSubview:label];
    self.titleLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(imageView.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(titleContentView.mas_centerY);
    }];
    
    UIButton *moreButton = [[UIButton alloc] init];
    [moreButton setTitle:@"更多>" forState:UIControlStateNormal];
    moreButton.titleLabel.font = KO_FONT(13);
    [moreButton setTitleColor:KOHexColor_AAAAAA forState:UIControlStateNormal];
    [titleContentView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.bottom.mas_equalTo(0);
    }];
}

@end
