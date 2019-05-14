//
//  KOBannerItemViewCell.m
//  KOFM
//
//  Created by Korune on 2019/1/1.
//  Copyright © 2019 Korune. All rights reserved.
//

#import "KOBannerItemViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface KOBannerItemViewCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation KOBannerItemViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self setupChildViews];
    }
    return self;
}

- (void)setupChildViews
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)setItem:(id<KOBannerProtocol>)item
{
    NSURL *url = [NSURL URLWithString:item.bannerImgURLString];
    [self.imageView sd_setImageWithURL:url placeholderImage:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
