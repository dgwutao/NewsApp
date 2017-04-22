//
//  MyCommentTableViewCell.h
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCommentTableViewCellDelegate<NSObject>

- (void) infoViewTapped:(NSInteger)index;

@end

@interface MyCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) id<MyCommentTableViewCellDelegate> delegate;
@property (assign, nonatomic) NSInteger index;
@end
