//
//  FeedDetailFloatView.m
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FeedDetailFloatView.h"

@implementation FeedDetailFloatView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.commentView.layer.cornerRadius = 14.0f;
    self.commentView.layer.masksToBounds = YES;
}

@end
