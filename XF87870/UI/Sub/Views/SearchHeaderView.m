//
//  SearchHeaderView.m
//  XF87870
//
//  Created by xf on 2016/11/25.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SearchHeaderView.h"

@implementation SearchHeaderView

- (void) awakeFromNib{
    [super awakeFromNib];
    self.borderView.layer.cornerRadius = 14.0f;
    self.borderView.layer.masksToBounds = YES;
}
- (IBAction)deleteButtonTapped:(id)sender {
    self.textField.text = @"";
    self.deleteButton.hidden = YES;
}

@end
