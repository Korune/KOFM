//
//  KORecommendSpecialColumnCell.m
//  KOFM
//
//  Created by Korune on 2019/1/3.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KORecommendSpecialColumnCell.h"
#import <Masonry.h>
#import "KOUtilities.h"
#import "KORecommendSpecialColumnItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface KORecommendSpecialColumnCell ()

@property (nonatomic, weak) UIImageView *albumImageView;
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *middleLabel;
@property (nonatomic, weak) UILabel *bottomLabel;

@end

@implementation KORecommendSpecialColumnCell

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

static NSString *s_cellID = @"KORecommendSpecialColumnCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    KORecommendSpecialColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:s_cellID];
    if (cell == nil) {
        cell = [[KORecommendSpecialColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)setItem:(KORecommendSpecialColumnItem *)item
{
    _item = item;
    
    NSURL *url = [NSURL URLWithString:item.coverPath];
    [self.albumImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.topLabel.text = item.title;
    self.middleLabel.text = item.subtitle;
    self.bottomLabel.text = item.footnote;
}

- (void)setupChildViews
{
    UIImageView *albumImageView = [[UIImageView alloc] init];
    albumImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:albumImageView];
    self.albumImageView = albumImageView;
    [albumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kKOCellStandardMargin);
        make.width.height.mas_equalTo(60);
        make.bottom.mas_equalTo(-kKOCellStandardMargin);
    }];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.font = KO_FONT(15);
    [self.contentView addSubview:topLabel];
    self.topLabel = topLabel;
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(albumImageView.mas_top);
        make.left.mas_equalTo(albumImageView.mas_right).mas_offset(kKOCellStandardMargin);
        make.right.mas_equalTo(-kKOCellStandardMargin);
    }];
    
    UILabel *middleLabel = [[UILabel alloc] init];
    middleLabel.font = KO_FONT(13);
    middleLabel.textColor = KOHexColor_AAAAAA;
    [self.contentView addSubview:middleLabel];
    self.middleLabel = middleLabel;
    [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLabel.mas_left);
        make.right.mas_equalTo(topLabel.mas_right);
        make.centerY.mas_equalTo(albumImageView.mas_centerY);
    }];
    
    UIImageView *smallImageView = [[UIImageView alloc] init];
    smallImageView.image = [UIImage imageNamed:@"find_specialicon"];
    [self.contentView addSubview:smallImageView];
   
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = KO_FONT(12);
    bottomLabel.textColor = KOHexColor_AAAAAA;
    [self.contentView addSubview:bottomLabel];
    self.bottomLabel = bottomLabel;
    
    [smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLabel.mas_left);
        make.width.height.mas_equalTo(14);
        make.centerY.mas_equalTo(bottomLabel.mas_centerY);
    }];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(smallImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(topLabel.mas_right);
        make.bottom.mas_equalTo(albumImageView.mas_bottom);
    }];
    
    // lineView
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kKOCellStandardMargin);
        make.right.mas_equalTo(kKOCellStandardMargin);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

@end
