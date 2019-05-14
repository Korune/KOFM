//
//  KOTableViewCell.m
//  KOFM
//
//  Created by Korune on 2018/12/10.
//  Copyright © 2018 Korune. All rights reserved.
//

#import "KOTableViewCell.h"

@implementation KOTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

static NSString *s_cellID = @"UITableViewCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    KOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:s_cellID];
    if (cell == nil) {
        cell = [[KOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_cellID];
    }
    return cell;
}

@end
