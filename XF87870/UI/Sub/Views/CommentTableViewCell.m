//
//  CommentTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 20.0f;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (IBAction)commentButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addCommentWithIndex:)]) {
        [self.delegate addCommentWithIndex:self.index];
    }
}

- (IBAction)likeButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(likeCommentWithIndex:success:)]) {
        __weak typeof (self) weakSelf = self;
        [self.delegate likeCommentWithIndex:self.index success:^{
            [weakSelf.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
            weakSelf.likeCountLabel.textColor = [UIColor colorWithHexValue:0xf46036 alpha:1.0f];
            weakSelf.likeCountLabel.text = [NSString stringWithFormat:@"%zi", weakSelf.likeCountLabel.text.integerValue + 1];
        }];
    }
}

@end
