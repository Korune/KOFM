//
//  KORecommendItemCell.m
//  KOFM
//
//  Created by Korune on 2018/12/20.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KORecommendItemCell.h"
#import <Masonry.h>
#import "KOUtilities.h"
#import "KORecommendGroupItem.h"
#import "KORecommendAlbumItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+KOExtension.h"

@interface KORecommendItemCell ()

@property (nonatomic, weak) UIImageView *bigImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIImageView *payImageView;

@end

@implementation KORecommendItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildViews];
    }
    return self;
}

- (void)setRecommendAlbumItem:(KORecommendAlbumItem *)recommendAlbumItem
{
    _recommendAlbumItem = recommendAlbumItem;
    
    NSURL *url = [NSURL URLWithString:recommendAlbumItem.albumCoverUrl290];
    [self.bigImageView sd_setImageWithURL:url placeholderImage:[UIImage ko_originalImageWithName:@"find_albumcell_cover_bg"]];
    self.payImageView.hidden = ![recommendAlbumItem.isPaid boolValue];
    self.titleLabel.text = recommendAlbumItem.trackTitle;
    self.detailLabel.text = recommendAlbumItem.title;
}

- (void)setupChildViews
{
    CGFloat itemW = [KORecommendItemCell itemW];
    
    UIImageView *bigImageView = [[UIImageView alloc] init];
    bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:bigImageView];
    self.bigImageView = bigImageView;
    [bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.width.mas_equalTo(itemW).priority(999);  // !!!: 由于自动计算 cell 宽高，此设置可以确定cell宽度,注意尽管降低了默认的优先级仅仅是为了计算中间步骤不至于约束冲突，最终显示时此约束仍然会生效
        make.height.mas_equalTo(itemW);
    }];
    
    UIImageView *payImageView = [[UIImageView alloc] init];
    payImageView.image = [UIImage ko_loadMainBundleImageWithFullName:@"albumtag_pay.png"];
    [self.contentView addSubview:payImageView];
    self.payImageView = payImageView;
    [payImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.height.mas_equalTo(34);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = KO_FONT(13);
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bigImageView.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *smallImageView = [[UIImageView alloc] init];
    smallImageView.image = [UIImage imageNamed:@"find_specialicon"];
    [self.contentView addSubview:smallImageView];
    [smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(10);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(0);
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.font = KO_FONT(12);
    detailLabel.textColor = KOHexColor_AAAAAA;
    detailLabel.numberOfLines = 2;
    [self.contentView addSubview:detailLabel];
    self.detailLabel = detailLabel;
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(smallImageView.mas_centerY);
        make.left.mas_equalTo(smallImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(-5).priority(UILayoutPriorityDefaultHigh); // !!!: 由于自动计算 cell 宽高，此设置可以确定cell高度,注意尽管降低了默认的优先级仅仅是为了计算中间步骤不至于约束冲突，最终显示时此约束仍然会生效
    }];
}

static NSString *s_itemCellID = @"KORecommendItemCell";
+ (NSString *)cellIdentifier
{
    return s_itemCellID;
}

+ (CGFloat)itemW
{
    CGFloat columnCount = 3;
    CGFloat margin = 10;
    CGFloat itemW = (KO_SCREEN_WIDTH - (columnCount + 1) * margin) / columnCount;
    return (int)itemW; // !!!: cell 高度为小数会导致约束冲突
}

+ (CGFloat)cellHeight
{
    return [KORecommendItemCell itemW] + 75;  
}

@end
