//
//  CommentTableViewCell.h
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentReplyItem.h"

@protocol CommentTableViewCellProtocol <NSObject>

@optional

- (void) addCommentWithIndex:(NSInteger)index;

- (void) likeCommentWithIndex:(NSInteger)index success:(void(^)())success;

@end

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) id<CommentTableViewCellProtocol> delegate;
@end
