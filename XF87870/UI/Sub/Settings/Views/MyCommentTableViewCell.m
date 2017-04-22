//
//  MyCommentTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MyCommentTableViewCell.h"

@implementation MyCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 20.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(infoViewTapped)];
    [self.infoView addGestureRecognizer:tap];
}

- (void)infoViewTapped
{
    if ([self.delegate respondsToSelector:@selector(infoViewTapped:)]) {
        [self.delegate infoViewTapped:self.index];
    }
}

@end
