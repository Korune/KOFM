//
//  KORecommendBannerCell.m
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KORecommendBannerCell.h"
#import "KOBannerView.h"
#import <Masonry.h>
#import "KOUtilities.h"
#import "KORecommendGroupItem.h"
#import "KORecommendLiveItem.h"

@interface KORecommendBannerCell ()<KOBannerViewDelegate>

@property (nonatomic, weak) KOBannerView *bannerView;
@property (nonatomic, weak) UILabel *leftTitleLabel;
@property (nonatomic, weak) UILabel *rightTitleLabel;
@property (nonatomic, weak) UILabel * detailTitleLabel;

@end

@implementation KORecommendBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupChildViews];
    }
    return self;
}

static NSString *s_cellID = @"KORecommendBannerCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    KORecommendBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:s_cellID];
    if (cell == nil) {
        cell = [[KORecommendBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_cellID];
    }
    return cell;
}

- (void)setGroup:(KORecommendGroupItem *)group
{
    _group = group;
    
    self.bannerView.photos = group.list;
    
    id object = group.list.firstObject;
    if ([object isKindOfClass:[KORecommendLiveItem class]]) {
        [self updateUIWithRecommendLiveItem:object];
    }
}

- (void)updateUIWithRecommendLiveItem:(KORecommendLiveItem *)liveItem
{
    self.leftTitleLabel.text = liveItem.name;
    
    double count = [liveItem.playCount doubleValue];
    if (count > 10000) {
        count = count / 10000.0;
        self.rightTitleLabel.text = [NSString stringWithFormat:@"%.01f万人参与", count];
    }else {
        self.rightTitleLabel.text = [NSString stringWithFormat:@"%d人参与", (int)(count)];
    }
    
    self.detailTitleLabel.text = liveItem.shortDescription;
}

#pragma mark - KOBannerViewDelegate 方法
// !!!:由于不好传递 indexPath，就传递了模型
- (void)koBannerView:(KOBannerView *)bannerView didSelectItemWithObject:(nonnull id)object
{
    if ([self.delegate respondsToSelector:@selector(koRecommendBannerCell:didSelectItemWithObject:)]) {
        [self.delegate koRecommendBannerCell:self didSelectItemWithObject:object];
    }
}

- (void)koBannerView:(KOBannerView *)bannerView didScrollToItemAtIndexPath:(NSIndexPath *)indexPath
{
    KORecommendLiveItem *liveItem = self.group.list[indexPath.item];
    [self updateUIWithRecommendLiveItem:liveItem];
}

#pragma mark -

- (void)setupChildViews
{
    CGFloat bannerViewW = KO_SCREEN_WIDTH - kKOCellStandardMargin * 2;
    CGFloat bannerViewH = (int)(bannerViewW * 0.36); // 约束不为整数会出现约束冲突
    KOBannerView *bannerView = [[KOBannerView alloc] init];
    bannerView.delegate = self;
    [self.contentView addSubview:bannerView];
    self.bannerView = bannerView;
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(kKOCellStandardMargin);
        make.right.mas_equalTo(-kKOCellStandardMargin);
        make.height.mas_equalTo(bannerViewH);
    }];
    
    UILabel *leftTitleLabel = [[UILabel alloc] init];
    leftTitleLabel.font = KO_FONT(15);
    leftTitleLabel.text = @" ";
    leftTitleLabel.textColor = [UIColor blackColor];
    [leftTitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:leftTitleLabel];
    self.leftTitleLabel = leftTitleLabel;
    [leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bannerView.mas_bottom).mas_offset(kKOCellStandardMargin);
        make.left.mas_offset(kKOCellStandardMargin);
    }];
    
    UILabel *rightTitleLabel = [[UILabel alloc] init];
    rightTitleLabel.font = KO_FONT(13);
    rightTitleLabel.text = @" ";
    rightTitleLabel.textColor = KOHexColor_AAAAAA;
    rightTitleLabel.textAlignment = NSTextAlignmentRight;
    [rightTitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:rightTitleLabel];
    self.rightTitleLabel = rightTitleLabel;
    [rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftTitleLabel.mas_top);
        make.right.mas_equalTo(-kKOCellStandardMargin);
        make.left.mas_equalTo(leftTitleLabel.mas_right).mas_offset(kKOCellStandardMargin);
    }];
    
    UILabel * detailTitleLabel = [[UILabel alloc] init];
    detailTitleLabel.font = KO_FONT(13);
    detailTitleLabel.text = @" ";
    detailTitleLabel.textColor = KOHexColor_AAAAAA;
    [self.contentView addSubview:detailTitleLabel];
    self.detailTitleLabel = detailTitleLabel;
    [detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftTitleLabel.mas_bottom).mas_offset(kKOCellStandardMargin);
        make.left.mas_equalTo(leftTitleLabel.mas_left);
        make.right.mas_equalTo(rightTitleLabel.mas_right);
        make.bottom.mas_equalTo(-kKOCellStandardMargin);
    }];
}

@end
