//
//  HardwareTableViewCell.h
//  XF87870
//
//  Created by liguohui on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HardwareInfoItem.h"


@interface HardwareTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;


- (void)setData:(HardwareInfoItem*)item;

@end
