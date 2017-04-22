//
//  SearcHistoryTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/11/28.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SearchHistoryTableViewCell.h"

@implementation SearchHistoryTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped)];
    [self.searchHistoryLabel addGestureRecognizer:tap];
}

- (void)labelTapped
{
    if ([self.delegate respondsToSelector:@selector(searchHistoryLabelTappedByIndex:)]) {
        [self.delegate searchHistoryLabelTappedByIndex:self.index];
    }
}

- (IBAction)searchHistoryButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteIndividulSearchHitoryByIndex:)]) {
        [self.delegate deleteIndividulSearchHitoryByIndex:self.index];
    }
}

@end
