//
//  FeedContentHeaderView.m
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FeedContentHeaderView.h"

@implementation FeedContentHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize :17.0f].fontName matrix:matrix];
    self.descriptionLabel.font = [UIFont fontWithDescriptor:desc size:17];
}

@end
