//
//  SearchTableViewCell.h
//  XF87870
//
//  Created by xf on 2016/11/25.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;

@end
