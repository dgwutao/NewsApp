//
//  CollectionInfoTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CollectionInfoTableViewCell.h"

@implementation CollectionInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tagLabel.layer.borderWidth = 1.0f;
    self.tagLabel.layer.borderColor = [[UIColor colorWithHexValue:0x8c8c8c alpha:1.0f] CGColor];
    self.tagLabel.layer.cornerRadius = 3.0f;
}

@end
