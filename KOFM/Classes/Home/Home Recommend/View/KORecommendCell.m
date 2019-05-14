//
//  KORecommendCell.m
//  KOFM
//
//  Created by Korune on 2018/12/10.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KORecommendCell.h"
#import <Masonry.h>
#import "KOUtilities.h"
#import "UIImage+KOExtension.h"
#import "KORecommendItemCell.h"
#import "KORecommendGroupItem.h"
#import "KORecommendCollectionView.h"

@interface KORecommendCell ()

@property (nonatomic, weak) KORecommendCollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation KORecommendCell

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

static NSString *s_cellID = @"KORecommendCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    KORecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:s_cellID];
    if (cell == nil) {
        cell = [[KORecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_cellID];
    }
    return cell;
}

#pragma mark -

- (void)setCollectionViewDataSourceAndDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate
                                  forIndexPath:(nonnull NSIndexPath *)indexPath
{
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.currentIndexPath = indexPath;
    [self.collectionView reloadData];
}

#pragma mark -

- (void)setupChildViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = CGSizeMake(200, 200); // 自动计算 cell 宽高
    flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, kKOCellStandardMargin, 0, kKOCellStandardMargin);
    self.flowLayout = flowLayout;
    
    KORecommendCollectionView *collectionView = [[KORecommendCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo([KORecommendItemCell cellHeight]);
    }];
    
    [collectionView registerClass:[KORecommendItemCell class] forCellWithReuseIdentifier:[KORecommendItemCell cellIdentifier]];
}

@end
