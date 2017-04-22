//
//  DiscoveryTableViewCell.m
//  XF87870
//
//  Created by xf on 2016/11/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "DiscoveryTableViewCell.h"

@implementation DiscoveryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = 16.0f;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)setData:(FindListItem*)item
{
    self.findItem = item;
    self.authorLabel.text = item.AuthorName;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.AuthorPhotoUrl] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
    self.dateLabel.text = item.CreateDate;
    self.tagLabel.text = item.Label;
    UITapGestureRecognizer *titleTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(interactAction:)];
    [self.titleLabel addGestureRecognizer:titleTapped];
    self.titleLabel.text = item.Name;
    UITapGestureRecognizer *contentTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(interactAction:)];
    [self.contentLabel addGestureRecognizer:contentTapped];
    self.contentLabel.text = item.Description;
    for (UIView *view in self.galleryView.subviews) {
        [view removeFromSuperview];
    }
    __weak typeof (self.galleryView) weakGalleryView = self.galleryView;
    if ([item.ColumnId isEqualToString:@"1_0"]) {
        self.tagImageView.image = [UIImage imageNamed:@"bg_find_label_news"];
        if (item.ImageUrlList.count > 1) {
            CGFloat width = (SCREEN_WIDTH - 30 - 12) / 3;
            for (NSInteger i = 0; i < item.ImageUrlList.count; i++) {
                UIImageView *multipleView = [self getImageViewWithUrl:[item.ImageUrlList objectAtIndex:i] andPlaceHolder:@"pic_find_new_2_load"];
                multipleView.tag = i;
                multipleView.userInteractionEnabled = YES;
                multipleView.contentMode = UIViewContentModeScaleToFill;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(interactAction:)];
                [multipleView addGestureRecognizer:tap];
                [self.galleryView addSubview:multipleView];
                CGFloat top = (i / 3) * (width + 6);
                CGFloat left = (i % 3) * (width + 6);
                [multipleView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakGalleryView.mas_top).offset(top);
                    make.left.equalTo(weakGalleryView.mas_left).offset(left);
                    make.width.and.height.mas_equalTo(width);
                }];
            }
            if (item.ImageUrlList.count % 3 == 0) {
                self.galleryViewHeight.constant = (item.ImageUrlList.count / 3) * 106 +  (item.ImageUrlList.count / 3 - 1) * 6;
            }else{
                self.galleryViewHeight.constant = (item.ImageUrlList.count / 3 + 1) * 106 +  (item.ImageUrlList.count / 3) * 6;
            }
        }else if (item.ImageUrlList.count == 1) {
            self.galleryViewHeight.constant = 164.0f;
            UIImageView *singleImage = [self getImageViewWithUrl:item.ImageUrlList.firstObject andPlaceHolder:@"pic_find_new_1_load"];
            singleImage.userInteractionEnabled = YES;
            singleImage.tag = 0;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(interactAction:)];
            [singleImage addGestureRecognizer:tap];
            [self.galleryView addSubview:singleImage];
            
            [singleImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakGalleryView.mas_top);
                make.left.equalTo(weakGalleryView.mas_left);
                make.width.mas_equalTo(218.0f);
                make.height.mas_equalTo(164.0f);
            }];
        }else{
            self.galleryViewHeight.constant = 0;
        }
    }else if ([item.ColumnId isEqualToString:@"3_1"] || [item.ColumnId isEqualToString:@"3_2"]) {
        self.tagImageView.image = [UIImage imageNamed:@"bg_find_label_evaluate"];
        [self setCommonGallery:item];
        CGFloat store = item.GameGrade.floatValue;
        NSInteger colorHex;
        if (store < 2.5) {
            colorHex = 0xc394fd;
        }else if(store < 5){
            colorHex = 0xec2929;
        }else if (store < 7.5){
            colorHex = 0xcffd800;
        }else{
            colorHex = 0x22ac38;
        }
        UIView *storeView = [[UIView alloc]init];
        storeView.frame = CGRectMake(SCREEN_WIDTH - 30 - 40, 0, 40, 40);
        storeView.backgroundColor = [UIColor colorWithHexValue:colorHex alpha:1.0];
        UILabel *storeLabel = [[UILabel alloc]init];
        storeLabel.text = item.GameGrade;
        storeLabel.font = [UIFont systemFontOfSize:19.0f];
        storeLabel.textColor = [UIColor whiteColor];
        [storeView addSubview:storeLabel];
        __weak typeof (storeView) weakStoreView = storeView;
        [storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakStoreView.mas_centerX);
            make.centerY.equalTo(weakStoreView.mas_centerY);
        }];
        [self.galleryView addSubview:storeView];
    }else if ([item.Label isEqualToString:@"推广"]) {
        self.tagImageView.image = [UIImage imageNamed:@"bg_find_label_extension"];
        [self setCommonGallery:item];
    }else if ([item.ColumnId isEqualToString:@"2_0"]) {
        self.tagImageView.image = [UIImage imageNamed:@"bg_find_label_vedio"];
        [self setCommonGallery:item];
    }
    if ([item.IsFavorite isEqualToString:@"0"]) {
        [self.collectButton setImage:[UIImage imageNamed:@"ic_find_more_collect"] forState:UIControlStateNormal];
    }else{
        [self.collectButton setImage:[UIImage imageNamed:@"ic_find_more_collect_seleted"] forState:UIControlStateNormal];
    }
    if ([item.Like isEqualToString:@"0"]) {
        [self.likeButton setTitle:@"" forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"comment_ic_like_default"] forState:UIControlStateNormal];
        [self.likeButton setTitleColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0f] forState:UIControlStateNormal];
    }else{
        [self.likeButton setTitle:item.Like forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
        [self.likeButton setTitleColor:[UIColor colorWithHexValue:0xf46036 alpha:1.0f] forState:UIControlStateNormal];
    }
    if ([item.Comment isEqualToString:@"0"]) {
        [self.commentButton setTitle:@"" forState:UIControlStateNormal];
    }else{
        [self.commentButton setTitle:item.Comment forState:UIControlStateNormal];
    }
}

- (void)setCommonGallery:(FindListItem*)item
{
    CGFloat galleryViewHeight = 0;
    __weak typeof (self.galleryView) weakGalleryView = self.galleryView;
    if ([item.ColumnId isEqualToString:@"2_0"]) {
        if (item.VideoImageUrl.length > 0) {
            galleryViewHeight = 186.0f;
            UIImageView *imageView = [self getImageViewWithUrl:item.VideoImageUrl andPlaceHolder:@"pic_column_load"];
            [self.galleryView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakGalleryView.mas_top);
                make.left.equalTo(weakGalleryView.mas_left);
                make.right.equalTo(weakGalleryView.mas_right);
                make.height.mas_equalTo(186.0f);
            }];
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"ic_find_video"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(interactAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.galleryView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakGalleryView.mas_centerX);
                make.centerY.equalTo(weakGalleryView.mas_centerY);
            }];
        }
    }else{
        if (item.ImageUrlList.count > 0) {
            galleryViewHeight = 186.0f;
            UIImageView *imageView = [self getImageViewWithUrl:item.ImageUrlList.firstObject andPlaceHolder:@"pic_column_load"];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 0;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(interactAction:)];
            [imageView addGestureRecognizer:tap];
            [self.galleryView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakGalleryView.mas_top);
                make.left.equalTo(weakGalleryView.mas_left);
                make.right.equalTo(weakGalleryView.mas_right);
                make.height.mas_equalTo(186.0f);
            }];
        }else{
            galleryViewHeight = 0;
        }
    }
    self.galleryViewHeight.constant = galleryViewHeight;
}

- (UIImageView*)getImageViewWithUrl:(NSString*)url andPlaceHolder:(NSString*)placeHolder
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleToFill;
    __weak typeof (self) weakSelf = self;
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolder] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!weakSelf.findItem.shareImageUrl) {
            weakSelf.findItem.shareImageUrl = imageURL.absoluteString;
        }
    }];
    return imageView;
}

- (void) interactAction:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *gesture = (UITapGestureRecognizer*)sender;
        id innerView = gesture.view;
        if ([innerView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView*)innerView;
            NSInteger index = imageView.tag;
            if ([self.delegate respondsToSelector:@selector(imageViewTapped:index:)]) {
                [self.delegate imageViewTapped:self.findItem index:index];
            }
        } else if([innerView isKindOfClass:[UILabel class]]){
            if ([self.delegate respondsToSelector:@selector(gotoDetailViewControler:)]) {
                [self.delegate gotoDetailViewControler:self.findItem];
            }
        }
    }else if([sender isKindOfClass:[UIButton class]]){
        if ([self.delegate respondsToSelector:@selector(playVideo:)]) {
            [self.delegate playVideo:self.findItem];
        }
    }
}

- (IBAction)commentButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showAllComment:)]) {
        [self.delegate showAllComment:self.findItem];
    }
}

- (IBAction)likeButtonTapped:(id)sender {
    if (![self.findItem.IsLike isEqualToString:@"0"]) {
        [XFToastView showTextToast:@"已经点过赞！"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(likeFindItem:success:)]) {
        UIButton *likeButton = (UIButton*)sender;
        __weak typeof (self) weakSelf = self;
        [self.delegate likeFindItem:self.findItem success:^{
            weakSelf.findItem.IsLike = @"1";
            [likeButton setTitle:[NSString stringWithFormat:@"%zi",likeButton.titleLabel.text.integerValue + 1] forState:UIControlStateNormal];
            [weakSelf.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
            [weakSelf.likeButton setTitleColor:[UIColor colorWithHexValue:0xf46036 alpha:1.0f] forState:UIControlStateNormal];
        }];
    }
}

- (IBAction)collectButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(collectFindItem:success:)]) {
        UIButton *collecButton = (UIButton*)sender;
        __weak typeof (self) weakSelf = self;
        [self.delegate
         collectFindItem:self.findItem
         success:^(BOOL result){
             if (result) {
                 weakSelf.findItem.IsFavorite = @"1";
                 [collecButton setImage:[UIImage imageNamed:@"ic_find_more_collect_seleted"] forState:UIControlStateNormal];
             }else{
                 weakSelf.findItem.IsFavorite = @"0";
                 [collecButton setImage:[UIImage imageNamed:@"ic_find_more_collect"] forState:UIControlStateNormal];
             }
        }];
    }
}

- (IBAction)shareButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareFindItem:)]) {
        [self.delegate shareFindItem:self.findItem];
    }
}

@end
