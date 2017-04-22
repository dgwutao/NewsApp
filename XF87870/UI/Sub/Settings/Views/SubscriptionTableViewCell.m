//
//  SubscriptionTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubscriptionTableViewCell.h"

@implementation SubscriptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 18.0f;
    self.avatarImageView.layer.masksToBounds = YES;
}

@end
