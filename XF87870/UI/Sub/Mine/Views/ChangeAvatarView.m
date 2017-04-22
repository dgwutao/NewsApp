//
//  ChangeAvatarView.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ChangeAvatarView.h"

@implementation ChangeAvatarView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void) showInWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - self.containerView.frame.size.height, SCREEN_WIDTH, self.containerView.frame.size.height);
    }];
}

- (void) hideView
{
    [UIView animateWithDuration:0.3f animations:^{
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.containerView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
