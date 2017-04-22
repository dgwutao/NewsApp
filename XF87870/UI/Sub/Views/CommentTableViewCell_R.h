//
//  CommentTableViewCell_R.h
//  XF87870
//
//  Created by xf on 2016/12/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTableViewCell.h"

@interface CommentTableViewCell_R : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) id<CommentTableViewCellProtocol> delegate;

@end
