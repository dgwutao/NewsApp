//
//  FeedContentFooterView.m
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FeedContentFooterView.h"

@implementation FeedContentFooterView

- (void) awakeFromNib{
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 24.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    
    self.focusButton.layer.borderWidth = 1.0f;
    self.focusButton.layer.borderColor = [[UIColor colorWithHexValue:0xf46036 alpha:1.0f] CGColor];
    self.focusButton.layer.cornerRadius = 3.0f;
}

@end
