//
//  SubscriptionDetailHeaderView.m
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubscriptionDetailHeaderView.h"

@implementation SubscriptionDetailHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 20.0f;
    self.avatarImageView.layer.masksToBounds = YES;
}

@end
