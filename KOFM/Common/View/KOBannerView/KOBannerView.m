//
//  KOBannerView.m
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KOBannerView.h"
#import "KOBannerItemViewCell.h"

static NSString *s_KOBannerViewCellID = @"KOBannerItemViewCell";

@interface KOBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *timer;
/// 显示 collectionView 的数据源数组
@property (nonatomic, copy) NSArray<id <KOBannerProtocol>> *carouselPhotos;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation KOBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettings];
        [self initSubviews];
    }
    return self;
}

- (void)initSettings
{
    self.scrollDuration = 3.0;
}

- (void)initSubviews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[KOBannerItemViewCell class] forCellWithReuseIdentifier:s_KOBannerViewCellID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.frame.size;
    self.collectionView.frame = self.bounds;
    
    CGFloat h = 35;
    CGFloat y = self.bounds.size.height - h;
    self.pageControl.frame = CGRectMake(0, y, self.bounds.size.width, h);
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    NSLog(@"%s", __FUNCTION__);
    // 销毁定时器
    [self invalidateTimer];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark -

- (void)setPhotos:(NSArray<id<KOBannerProtocol>> *)photos
{
    _photos = photos;
    
    // 设置数据时在 photos 第一个之前和最后一个之后分别插入数据
    NSMutableArray *tempArray = [NSMutableArray new];
    [tempArray addObjectsFromArray:photos];
    [tempArray addObject:photos.firstObject];
    [tempArray insertObject:photos.lastObject atIndex:0];
    self.carouselPhotos = [NSArray arrayWithArray:tempArray];
    
    if (self.timer == nil) {
        [self setupTimer];
    }
    self.pageControl.numberOfPages = photos.count;
    [self.collectionView reloadData];
    // 首先显示第 1 个 item（不是第 0 个）
    [self.collectionView setContentOffset:CGPointMake(_collectionView.bounds.size.width, 0)];
}

#pragma mark - 定时器相关

- (void)setupTimer
{
    [self invalidateTimer];
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.scrollDuration target:self selector:@selector(showNextItem) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)showNextItem
{
    if (self.collectionView.isDragging) {
        return;
    }
    CGFloat x = self.collectionView.contentOffset.x + self.flowLayout.itemSize.width;
    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)invalidateTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - UICollectionViewDataSource 方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.carouselPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id photo = self.carouselPhotos[indexPath.item];
    KOBannerItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:s_KOBannerViewCellID forIndexPath:indexPath];
    cell.item = photo;
    return cell;
}

#pragma mark - UIScrollViewDelegate 方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id object = self.carouselPhotos[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(koBannerView:didSelectItemWithObject:)]) {
        [self.delegate koBannerView:self didSelectItemWithObject:object];
    }
}

#pragma mark - UIScrollViewDelegate 等相关方法
// 手动拖拽结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"%s", __FUNCTION__);
    
    [self autoScrollAction];
    // 拖拽动作后间隔 scrollDuration 继续轮播
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollDuration]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    NSLog(@"%s", __FUNCTION__);
    [self autoScrollAction];
}

- (void)autoScrollAction
{
    int index = self.collectionView.contentOffset.x / self.flowLayout.itemSize.width;
    if (index == 0) {  // 滚动到左边
        CGFloat x = self.flowLayout.itemSize.width * (self.carouselPhotos.count - 2);
        [self.collectionView setContentOffset:CGPointMake(x, 0) animated:NO]; //
        self.pageControl.currentPage = self.carouselPhotos.count - 2;
        
    } else if (index == self.carouselPhotos.count - 1) { // 滚动到右边
        CGFloat x = self.flowLayout.itemSize.width;
        [self.collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
        self.pageControl.currentPage = 0;
        
    } else {
        self.pageControl.currentPage = index - 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(koBannerView:didScrollToItemAtIndexPath:)]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.pageControl.currentPage inSection:0];
        [self.delegate koBannerView:self didScrollToItemAtIndexPath:indexPath];
    }
}

@end
