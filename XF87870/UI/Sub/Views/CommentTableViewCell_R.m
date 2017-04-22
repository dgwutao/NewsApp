//
//  CommentTableViewCell_R.m
//  XF87870
//
//  Created by xf on 2016/12/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommentTableViewCell_R.h"

@implementation CommentTableViewCell_R

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
