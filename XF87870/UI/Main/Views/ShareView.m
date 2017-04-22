//
//  ShareView.m
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation ShareView

- (void)installSocialWithOptions:(ShareToSocialOptions)options{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.backgroundView addGestureRecognizer:tap];
    NSInteger index = 0;
    if (options & XFWeChatFriend) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_wxf" andTitle:@"微信好友" andOption:XFWeChatFriend];
        index++;
    }
    if (options & XFWeChatMoments) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_wxp" andTitle:@"微信朋友圈" andOption:XFWeChatMoments];
        index++;
    }
    if (options & XFWeibo) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_sina" andTitle:@"微博" andOption:XFWeibo];
        index++;
    }
    if (options & XFQQ) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_qq" andTitle:@"QQ好友" andOption:XFQQ];
        index++;
    }
    if (options & XFQZone) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_zone" andTitle:@"QQ空间" andOption:XFQZone];
        index++;
    }
    if (options & XFCollect) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_collect" andTitle:@"收藏" andOption:XFCollect];
        index++;
    }
    if (options & XFLike) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_like" andTitle:@"点赞" andOption:XFLike];
        index++;
    }
    if (options & XFCopyUrl) {
        CGSize size = [self getViewPositonSize:index];
        [self generateViewWithLeftOffset:size.width top:size.height andButtonImage:@"btn_find_ic_link" andTitle:@"复制链接" andOption:XFCopyUrl];
    }
}

- (UIView*)generateViewWithLeftOffset:(CGFloat)left top:(CGFloat)top
                       andButtonImage:(NSString*)imageName
                             andTitle:(NSString*)title
                              andOption:(ShareToSocialOptions)option
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexValue:0xf5f5f5 alpha:1.0];
    [self.container addSubview:view];
    __weak typeof (self.container) weakContainer = self.container;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakContainer.mas_top).offset(top + 15);
        make.left.equalTo(weakContainer.mas_left).offset(left);
        make.height.mas_equalTo(230 / 2);
        make.width.mas_equalTo(SCREEN_WIDTH / 4);
    }];
    __weak typeof (view) weakView = view;
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tag = option;
    [button addTarget:self action:@selector(shareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor colorWithHexValue:0x5c5c5c alpha:1.0f];
    label.text = title;
    [view addSubview:button];
    [view addSubview:label];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView.mas_top);
        make.centerX.equalTo(weakView.mas_centerX);
    }];
    __weak typeof (button) weakButton = button;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakButton.mas_bottom).offset(15);
        make.centerX.equalTo(weakView.mas_centerX);
    }];
    return view;
}

- (void)shareButtonTapped:(id)sender
{
    UIButton *button = (UIButton*)sender;
    ShareToSocialOptions option = button.tag;
    switch (option) {
        case XFQQ:
        {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                messageObject.title = self.feedName;
                messageObject.text = self.feedDescription;
                UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                                     shareObjectWithTitle:self.feedName descr:self.feedDescription
                                                     thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
                shareObject.webpageUrl = self.webPageUrl;
                messageObject.shareObject = shareObject;
                [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (!error) {
                        [XFToastView showTextToast:@"QQ好友分享成功！"];
                    }else{
                        
                    }
                }];
            }else{
                [XFToastView showTextToast:@"你没有安装QQ！"];
            }
            break;
        }
        case XFWeibo:
        {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                messageObject.title = self.feedName;
                messageObject.text = self.feedDescription;
                UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                                     shareObjectWithTitle:self.feedName descr:self.feedDescription
                                                     thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
                shareObject.webpageUrl = self.webPageUrl;
                messageObject.shareObject = shareObject;
                [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (!error) {
                        [XFToastView showTextToast:@"新浪微博分享成功！"];
                    }else{
                        
                    }
                }];
            }else{
                [XFToastView showTextToast:@"你没有安装新浪微博！"];
            }
            break;
        }
        case XFQZone:
        {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                messageObject.title = self.feedName;
                messageObject.text = self.feedDescription;
                UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                                     shareObjectWithTitle:self.feedName descr:self.feedDescription
                                                     thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
                shareObject.webpageUrl = self.webPageUrl;
                messageObject.shareObject = shareObject;
                [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (!error) {
                        [XFToastView showTextToast:@"QQ空间分享成功！"];
                    }else{
                        
                    }
                }];
            }else{
                [XFToastView showTextToast:@"你没有安装QQ空间！"];
            }
            break;
        }
        case XFCollect:
        {
            [[XFCommonFunc sharedInstance]addFavoriteInfoWithCid:self.cid infoId:self.infoId success:^{
                [XFToastView showTextToast:@"收藏成功！"];
            } failure:^(NSError *error) {
                
            }];
            break;
        }
        case XFLike:
        {
            [[XFCommonFunc sharedInstance]infoLikeWithCid:self.cid infoId:self.infoId success:^{
                [XFToastView showTextToast:@"点赞成功！"];
            } failure:^(NSError *error) {
                
            }];
            break;
        }
        case XFWeChatFriend:
        {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                messageObject.title = self.feedName;
                messageObject.text = self.feedDescription;
                UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                                     shareObjectWithTitle:self.feedName descr:self.feedDescription
                                                     thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
                shareObject.webpageUrl = self.webPageUrl;
                messageObject.shareObject = shareObject;
                [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (!error) {
                        [XFToastView showTextToast:@"微信好友分享成功！"];
                    }else{
                        
                    }
                }];
            }else{
                [XFToastView showTextToast:@"你没有安装微信！"];
            }
            break;
        }
        case XFWeChatMoments:
        {
            if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                messageObject.title = self.feedName;
                messageObject.text = self.feedDescription;
                UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                                     shareObjectWithTitle:self.feedName descr:self.feedDescription
                                                     thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
                shareObject.webpageUrl = self.webPageUrl;
                messageObject.shareObject = shareObject;
                [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (!error) {
                        [XFToastView showTextToast:@"微信朋友圈分享成功！"];
                    }else{
                        
                    }
                }];
            }else{
                [XFToastView showTextToast:@"你没有安装微信！"];
            }
            break;
        }
        case XFCopyUrl:
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.webPageUrl;
            [XFToastView showTextToast:@"复制链接成功！"];
            break;
        }
        default:
            break;
    }
}

- (void) showWithOptions:(ShareToSocialOptions)options
{
    [self installSocialWithOptions:options];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.container.frame = CGRectMake(0, SCREEN_HEIGHT - self.container.frame.size.height, SCREEN_WIDTH, self.container.frame.size.height);
    }];
}

- (void)hideView
{
    [UIView animateWithDuration:0.3f animations:^{
        self.container.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.container.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (IBAction)cancelButtonTapped:(id)sender
{
    [self hideView];
}

- (CGSize)getViewPositonSize:(NSInteger)index
{
    CGSize size = CGSizeMake(0, 0);
    if (index < 4) {
        size.width = index * SCREEN_WIDTH / 4;
    }else{
        size.width = (index - 4) * SCREEN_WIDTH / 4;
        size.height = 230 / 2;
    }
    return size;
}

@end
