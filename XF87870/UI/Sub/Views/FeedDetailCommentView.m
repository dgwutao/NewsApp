//
//  FeedDetailCommentView.m
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FeedDetailCommentView.h"

@implementation FeedDetailCommentView
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewTapped)];
    [self.backgroundView addGestureRecognizer:tap];
}

- (void)backgroundViewTapped
{
    [self.textView resignFirstResponder];
    [self removeFromSuperview];
}
@end
