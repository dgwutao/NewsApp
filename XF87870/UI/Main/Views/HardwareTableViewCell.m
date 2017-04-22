//
//  HardwareTableViewCell.m
//  XF87870
//
//  Created by liguohui on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "HardwareTableViewCell.h"

@implementation HardwareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(HardwareInfoItem*)item
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",item.ImgUrl,item.Img]] placeholderImage:[UIImage imageNamed:@"pic_equipment_load.jpg"]];
    
    [self.title_label setText:item.Name];
    [self.content_label setText:item.Description];
    
    
    
    
}

@end
