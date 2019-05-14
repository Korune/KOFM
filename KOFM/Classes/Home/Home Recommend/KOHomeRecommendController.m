//
//  KOHomeRecommendController.m
//  KOFM
//
//  Created by Korune on 2018/12/8.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOHomeRecommendController.h"
#import "KOHomeRecommendDataManager.h"
#import "KORecommendGroupItem.h"
#import "KORecommendCell.h"
#import "KORecommendItemCell.h"
#import "KORecommendCollectionView.h"
#import "KORecommendAlbumItem.h"
#import "KORecommendHeaderView.h"
#import "KORecommendBannerCell.h"
#import "KORecommendLiveItem.h"
#import "KORecommendSpecialColumnCell.h"
#import "KORecommendSpecialColumnItem.h"

@interface KOHomeRecommendController ()<UICollectionViewDelegate, UICollectionViewDataSource, KORecommendBannerCellDelegate>

@property (nonatomic, strong) NSMutableArray<KORecommendGroupItem *> *groups;
@property (nonatomic) dispatch_group_t dispatchGroup;

@end

@implementation KOHomeRecommendController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // 自动计算 cell 高度
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 自动计算 sectionHeaderHeight
    self.tableView.estimatedSectionHeaderHeight = 35;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.dispatchGroup = dispatch_group_create();
    
    dispatch_group_enter(self.dispatchGroup);
    // 编辑推荐
    [KOHomeRecommendDataManager getEditorRecommendAlbums:^(KORecommendGroupItem * _Nullable group, NSError * _Nullable error) {
        group.sortID = 1;
        group.groupType = KORecommendGroupType13;
        [self.groups addObject:group];
        dispatch_group_leave(self.dispatchGroup);
    }];
    
    dispatch_group_enter(self.dispatchGroup);
    // 直播信息
    [KOHomeRecommendDataManager getLiveMessage:^(KORecommendGroupItem * _Nullable group, NSError * _Nullable error) {
        group.sortID = 2;
        group.groupType = KORecommendGroupTypeAD;
        [self.groups addObject:group];
        dispatch_group_leave(self.dispatchGroup);
    }];
    
    dispatch_group_enter(self.dispatchGroup);
    // 广州听
    [KOHomeRecommendDataManager getCityAlbums:^(KORecommendGroupItem * _Nullable group, NSError * _Nullable error) {
        group.sortID = 3;
        group.groupType = KORecommendGroupType13;
        [self.groups addObject:group];
        dispatch_group_leave(self.dispatchGroup);
    }];
    
    dispatch_group_enter(self.dispatchGroup);
    // 精品听单
    [KOHomeRecommendDataManager getSpecialColumn:^(KORecommendGroupItem * _Nullable group, NSError * _Nullable error) {
        group.sortID = 4;
        group.groupType = KORecommendGroupTypeN1;
        [self.groups addObject:group];
        dispatch_group_leave(self.dispatchGroup);
    }];
    
    dispatch_group_enter(self.dispatchGroup);
    // "热门推荐-听其他"
    [KOHomeRecommendDataManager getHotRecommendAlbums:^(NSArray<KORecommendGroupItem *> * _Nullable groups, NSError * _Nullable error) {
        [self.groups addObjectsFromArray:groups];
        dispatch_group_leave(self.dispatchGroup);
    }];
    
    dispatch_group_notify(self.dispatchGroup, dispatch_get_main_queue(), ^{
        // 以 sortID 排序
        [self.groups sortUsingComparator:^NSComparisonResult(KORecommendGroupItem *obj1, KORecommendGroupItem *obj2) {
            if (obj1.sortID > obj2.sortID) {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
        [self.tableView reloadData];
    });
}
    
#pragma mark - UITableView 相关代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    KORecommendGroupItem *group = self.groups[section];
    if (group.groupType == KORecommendGroupTypeN1) {
        return group.list.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KORecommendGroupItem *group = self.groups[indexPath.section];
    UITableViewCell *cell;
    if (group.groupType == KORecommendGroupType13) {
        KORecommendCell *recommendCell = [KORecommendCell cellWithTableView:tableView];
        [recommendCell setCollectionViewDataSourceAndDelegate:self forIndexPath:indexPath];
        cell = recommendCell;
      
    } else if (group.groupType == KORecommendGroupTypeAD) {
        KORecommendBannerCell *bannerCell = [KORecommendBannerCell cellWithTableView:tableView];
        bannerCell.delegate = self;
        bannerCell.group = group;
        cell = bannerCell;
        
    } else if (group.groupType == KORecommendGroupTypeN1) {
        KORecommendSpecialColumnCell *specialColumnCell = [KORecommendSpecialColumnCell cellWithTableView:tableView];
        KORecommendSpecialColumnItem *item = group.list[indexPath.row];
        specialColumnCell.item = item;
        cell = specialColumnCell;
        
    } else {
        static NSString *cellID = @"UITableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KORecommendGroupItem *group = self.groups[section];
    KORecommendHeaderView *headerView = [KORecommendHeaderView headViewWithTableView:tableView];
    headerView.title = group.title;
    return headerView;
}

#pragma mark - KORecommendBannerCellDelegate 方法

- (void)koRecommendBannerCell:(KORecommendBannerCell *)cell didSelectItemWithObject:(nonnull id)object
{
    if ([object isKindOfClass:[KORecommendLiveItem class]]) {
        NSLog(@"KORecommendBannerCell 点击了的 shortDescription 为：%@", ((KORecommendLiveItem *)object).shortDescription);
    }
}

#pragma mark - UICollectionView 相关代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isKindOfClass:[KORecommendCollectionView class]]) {
        KORecommendCollectionView *recommendCollectionView = (KORecommendCollectionView *)collectionView;
        KORecommendGroupItem *group = self.groups[recommendCollectionView.currentIndexPath.row];
        return group.list.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isKindOfClass:[KORecommendCollectionView class]]) {
        // 根据 KORecommendCollectionView 的 currentIndexPath 取数据
        KORecommendCollectionView *recommendCollectionView = (KORecommendCollectionView *)collectionView;
        KORecommendItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[KORecommendItemCell cellIdentifier] forIndexPath:indexPath];
        NSInteger section = recommendCollectionView.currentIndexPath.section;
        KORecommendGroupItem *group = self.groups[section];
        id object = group.list.firstObject;
        if ([object isKindOfClass:[KORecommendAlbumItem class]]) {
            cell.recommendAlbumItem = group.list[indexPath.item];
        }
        return cell;
    } else {
        static NSString *cellID = @"UICollectionViewCell";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     if ([collectionView isKindOfClass:[KORecommendCollectionView class]]) {
         NSLog(@"点击 KORecommendCollectionView indexPath.item 为：%ld", indexPath.item);
     }
}

#pragma mark - get & set 方法

- (NSMutableArray<KORecommendGroupItem *> *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray new];
    }
    return _groups;
}

@end
