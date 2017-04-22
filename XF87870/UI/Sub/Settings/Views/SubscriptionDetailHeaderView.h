//
//  SubscriptionDetailHeaderView.h
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscriptionDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
