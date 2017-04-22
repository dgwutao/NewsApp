//
//  DiscoveryTableViewCell.h
//  XF87870
//
//  Created by xf on 2016/11/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindListItem.h"

@protocol FindTableViewCellProtocol <NSObject>

- (void) imageViewTapped:(FindListItem*)item index:(NSInteger)index;

- (void) playVideo:(FindListItem*)item;

- (void) gotoDetailViewControler:(FindListItem*)item;

- (void) likeFindItem:(FindListItem*)item success:(void(^)())success;

- (void) collectFindItem:(FindListItem*)item success:(void(^)(BOOL))success;

- (void) shareFindItem:(FindListItem*)item;

- (void) showAllComment:(FindListItem*)item;

@end

@interface DiscoveryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *galleryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *galleryViewHeight;
@property (weak, nonatomic) FindListItem *findItem;

@property (weak, nonatomic) id<FindTableViewCellProtocol> delegate;

- (void)setData:(FindListItem*)item;
@end
