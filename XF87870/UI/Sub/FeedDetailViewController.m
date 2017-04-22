//
//  FeedDetailViewController.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "FeedDetailItem.h"
#import "FeedContentHeaderView.h"
#import "FeedContentFooterView.h"
#import "FeedDetailFloatView.h"
#import "RecommendTableViewCell.h"
#import "CommentTableViewCell.h"
#import "FeedTableViewSectionHeader.h"
#import "RecommendItem.h"
#import "CommentItem.h"
#import "CommentsViewController.h"
#import "KRVideoPlayerController.h"
#import "XFXMLParser.h"
#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "FeedDetailCommentView.h"

static NSString *recommendTableViewCellIdentifier = @"RecommendTableViewCellIdentifier";
static NSString *commentTableViewCellIdentifier = @"CommentTableViewCellIdentifier";
static NSString *feedTableViewSectionHeaderIdentifier = @"FeedTableViewSectionHeaderIdentifier";

@interface FeedDetailViewController ()<UITextViewDelegate,CommentTableViewCellProtocol>
{
    FeedContentHeaderView *_contentHeader;
    FeedContentFooterView *_contentFooter;
    FeedDetailFloatView *_floatView;
    FeedDetailCommentView *_commentView;
    NSMutableArray *_recommends;
    NSMutableArray *_comments;
    FeedDetailItem *_feed;
    CGFloat _headerHeight;
    CGFloat _footerHeight;
}
@property (strong, nonatomic) NSString *shareImageUrl;
@end

@implementation FeedDetailViewController

- (void)loadView{
    [super loadView];
    self.navbarTranslucent = NO;
    self.PullRefreshOptions = XFPullRefreshOptionPullDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [super setRightNavItemWithImage:@"ic_nav_more"];
    _recommends = [NSMutableArray new];
    _comments = [NSMutableArray new];
    [self.dataSource addObject:_recommends];
    [self.dataSource addObject:_comments];
    __weak typeof (self) weakSelf = self;
    _contentHeader = [[[NSBundle mainBundle] loadNibNamed:@"FeedContentHeaderView" owner:self options:nil] firstObject];
    _contentFooter = [[[NSBundle mainBundle] loadNibNamed:@"FeedContentFooterView" owner:self options:nil] firstObject];
    _floatView = [[[NSBundle mainBundle] loadNibNamed:@"FeedDetailFloatView" owner:self options:nil] firstObject];
    
    [self.view addSubview:_floatView];
    [_floatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(48);
    }];
    
    [self configActions];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)rightItemAction{
    ShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] firstObject];
    shareView.cid = self.Cid;
    shareView.infoId = _feed.Id;
    shareView.webPageUrl = _feed.ShareUrl;
    shareView.feedName = _feed.Name;
    shareView.feedDescription = _feed.Description;
    shareView.shareImageUrl = self.shareImageUrl;
    [shareView showWithOptions:XFWeChatFriend|XFWeChatMoments|XFQQ|XFQZone|XFWeibo|XFCollect|XFLike|XFCopyUrl];
}

//columnid:1_0 代表新闻分类
//columnid:2_0 代表视频分类
//columnid:3_1 代表游戏评测分类
//columnid:3_2 代表硬件评测分类
//columnid:6_1 代表vr游戏分类
//columnid:6_2 代表普通游戏分类
//columnid:7_0 精品栏目详情页
//columnid:7_1 代表精品栏目（含视频）
//columnid:7_2 代表精品栏目（不含视频）
//columnid:11_0 代表硬件库
//涉及到大分类数据筛选的  1代表发现 2代表游戏 3代表硬件

- (void) loadData:(void(^)(void)) completion{
    NSString *url;
#pragma 新闻
    if ([self.ColumnId isEqualToString:@"1_0"]) {
        url = InfoDetail;
    }
#pragma 视频
    else if ([self.ColumnId isEqualToString:@"2_0"]) {
        url = VideoInfoDetail;
    }
#pragma 3_1游戏评测 3_2硬件评测
    else if ([self.ColumnId isEqualToString:@"3_1"] || [self.ColumnId isEqualToString:@"3_2"]) {
        url = EvaluationInfoDetail;
    }
#pragma columnid:7_0 精品栏目详情页 columnid:7_1 代表精品栏目（不含视频） columnid:7_2 代表精品栏目（含视频）
    else if ([self.ColumnId isEqualToString:@"7_0"] || [self.ColumnId isEqualToString:@"7_1"] || [self.ColumnId isEqualToString:@"7_2"]) {
        url = BoutiqueInfoDetail;
    }
    
#pragma columnid:11_0
    else if ([self.ColumnId isEqualToString:@"11_0"]) {
        url = HardwareInfoDetail;
    }

    NSDictionary *params = @{@"uid":DefaultUid,
                             @"id":self.Id};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:url params:params
     parser:[XFHttpResponseParser sharedParser].FeedInfoDetailParser progress:nil
     success:^(id response) {
         _feed = (FeedDetailItem*)response;
         _contentHeader.titleLabel.text = _feed.Name;
         _contentHeader.sourceLabel.text = _feed.From;
         _contentHeader.authorLabel.text = _feed.AuthorInfo.Name;
         _contentHeader.dateLabel.text = _feed.CreateDate;
         NSString *discription = [NSString stringWithFormat:@"导语：%@",_feed.Description];
         _contentHeader.descriptionLabel.text = discription;
         if (![_feed.Comment isEqualToString:@"0"]) {
             _floatView.commentCountLabel.text = _feed.Comment;
         }
         if (![_feed.IsFavorite isEqualToString:@"0"]) {
             [_floatView.collectButton setImage:[UIImage imageNamed:@"ic_find_more_collect_seleted"] forState:UIControlStateNormal];
         }
         if (![_feed.IsFavoriteAdmin isEqualToString:@"0"]) {
             [_contentFooter.focusButton setTitle:@"已关注" forState:UIControlStateNormal];
         }
         CGSize titleSize = [_feed.Name sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 32.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}];
         CGSize contentDescriptionSize = [discription sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 32.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
         _headerHeight = titleSize.height + contentDescriptionSize.height + 93.0f;
         _contentFooter.sourceLabel.text = _feed.From;
         _contentFooter.likeCountLabel.text = _feed.Like;
         if (![_feed.IsLike isEqualToString:@"0"]) {
             [_contentFooter.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
             _contentFooter.likeCountLabel.textColor = [UIColor colorWithHexValue:0xf46036 alpha:1.0f];
         }
         [_contentFooter.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_feed.AuthorInfo.UserPhoto] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
         _contentFooter.authorNameLabel.text = _feed.AuthorInfo.Name;
         _contentFooter.authorDescriptionLabel.text = _feed.AuthorInfo.Description;
         
         CGSize authorDescriptionSize = [_feed.AuthorInfo.Description sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 32.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
         _footerHeight = authorDescriptionSize.height + 445.0f;
         
         NSString *xml = [NSString stringWithFormat:@"<root>%@</root>",[_feed.Content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""]];
         XFXMLParser *xmlParser = [[XFXMLParser alloc]initWithNSData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
         NSArray *elements = [xmlParser parse];
         CGFloat contentHight = 0;
         for (UIView *view in _contentHeader.contentView.subviews) {
             [view removeFromSuperview];
         }
         _contentHeader.contentViewHeight.constant = contentHight;
         
         for (NSInteger i = 0; i < elements.count; i ++) {
             NSDictionary *element = [elements objectAtIndex:i];
             NSString *key = [[element allKeys]firstObject];
             if ([key isEqualToString:@"text"]) {
                 NSTextAlignment aligment = NSTextAlignmentLeft;
                 CGFloat fontSize = 17.0f;
                 CGFloat topMargin = 14.0f;
                 NSInteger preIndex = i - 1;
                 NSInteger nextIndex = i + 1;
                 if (preIndex >= 0 && nextIndex < elements.count) {
                     NSString *preKey = [[elements objectAtIndex:preIndex] allKeys].firstObject;
                     NSString *nextKey = [[elements objectAtIndex:nextIndex] allKeys].firstObject;
                     if ([preKey isEqualToString:@"img"] &&
                         [nextKey isEqualToString:@"br"]) {
                         aligment = NSTextAlignmentCenter;
                         fontSize = 14.0f;
                         topMargin = 8.0f;
                     }
                 }
                 UILabel *label = [[UILabel alloc]init];
                 label.font = [UIFont systemFontOfSize:fontSize];
                 label.textColor = [UIColor colorWithHexValue:0x323232 alpha:1.0];
                 label.textAlignment = aligment;
                 label.numberOfLines = 0;
                 label.userInteractionEnabled = NO;
                 label.text = [element objectForKey:key];
                 CGSize textSize = [[element objectForKey:key] sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 32.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
                 [_contentHeader.contentView addSubview:label];
                 [label mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(_contentHeader.contentView.mas_top).offset(contentHight + topMargin);
                     make.left.equalTo(_contentHeader.contentView.mas_left);
                     make.right.equalTo(_contentHeader.contentView.mas_right);
                 }];
                 contentHight += textSize.height + topMargin;
             }else if([key isEqualToString:@"img"]){
                 UIImageView *imageView = [[UIImageView alloc]init];
                 imageView.contentMode = UIViewContentModeScaleAspectFit;
                 imageView.userInteractionEnabled = NO;
                 [imageView sd_setImageWithURL:[NSURL URLWithString:[element objectForKey:key]] placeholderImage:[UIImage imageNamed:@"pic_column_load"]];
                 [_contentHeader.contentView addSubview:imageView];
                 [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(_contentHeader.contentView.mas_top).offset(contentHight + 10.0f);
                     make.left.equalTo(_contentHeader.contentView.mas_left);
                     make.right.equalTo(_contentHeader.contentView.mas_right);
                     make.height.mas_equalTo((SCREEN_WIDTH - 32) * 9 / 16);
                 }];
                 contentHight += (SCREEN_WIDTH - 32) * 9 / 16 + 10.0f;
                 
                 if (!_shareImageUrl) _shareImageUrl = [element objectForKey:key];
             }else if([key isEqualToString:@"video"]){
                 UIImageView *imageView = [[UIImageView alloc]init];
                 imageView.contentMode = UIViewContentModeScaleAspectFit;
                 imageView.userInteractionEnabled = NO;
                 [imageView sd_setImageWithURL:[NSURL URLWithString:_feed.PlayerImage] placeholderImage:[UIImage imageNamed:@"pic_column_load"]];
                 [_contentHeader.contentView addSubview:imageView];
                 [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(_contentHeader.contentView.mas_top).offset(contentHight + 10.0f);
                     make.left.equalTo(_contentHeader.contentView.mas_left);
                     make.right.equalTo(_contentHeader.contentView.mas_right);
                     make.height.mas_equalTo((SCREEN_WIDTH - 32) * 9 / 16);
                 }];
                 UIButton *button = [[UIButton alloc]init];
                 [button setImage:[UIImage imageNamed:@"ic_find_video"] forState:UIControlStateNormal];
                 [button addTarget:self action:@selector(videoAction:) forControlEvents:UIControlEventTouchUpInside];
                 [_contentHeader.contentView addSubview:button];
                 [button mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.centerX.equalTo(imageView.mas_centerX);
                     make.centerY.equalTo(imageView.mas_centerY);
                 }];
                 contentHight += (SCREEN_WIDTH - 32) * 9 / 16 + 10.0f;
                 
                 if (!_shareImageUrl) _shareImageUrl = _feed.PlayerImage;
             }
         }
         _contentHeader.contentViewHeight.constant = contentHight;
         
         UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _headerHeight + contentHight + _footerHeight)];
         container.opaque = YES;
         container.backgroundColor = [UIColor whiteColor];
         [container addSubview:_contentHeader];
         [container addSubview:_contentFooter];
         __weak typeof (container) weakContainer = container;
         [_contentHeader mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(weakContainer.mas_top);
             make.left.equalTo(weakContainer.mas_left);
             make.right.equalTo(weakContainer.mas_right);
             make.height.mas_equalTo(_headerHeight + contentHight);
         }];
         
         [_contentFooter mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(_contentHeader.mas_bottom);
             make.left.equalTo(weakContainer.mas_left);
             make.right.equalTo(weakContainer.mas_right);
             make.height.mas_equalTo(_footerHeight);
         }];
         weakSelf.tableView.tableHeaderView = container;
         for (id recommend in _feed.RecommendList) {
             [_recommends addObject:recommend];
         }
         [weakSelf.tableView reloadData];
         if (completion) {
             completion();
         }
     } failure:^(NSError *error) {
         if (completion) {
             completion();
         }
     }];
    NSDictionary *params2 = @{@"uid":DefaultUid,
                              @"pagesize":@"5",
                              @"pageindex":@"1",
                              @"sort":@"recent",
                              @"id":self.Id};
    [self.sessionManager
     sendGetHttpRequestWithUrl:CommentInfo
     params:params2 parser:[XFHttpResponseParser sharedParser].CommentInfoParser progress:nil
     success:^(id response) {
         NSArray *comments = (NSArray*)response;
         for (id comment in comments) {
             [_comments addObject:comment];
         }
         [weakSelf.tableView reloadData];
     } failure:^(NSError *error) {
         
     }];
}

- (void)pullDownRefresh:(void(^)(void)) completion
{
    [self loadData:completion];
}

- (void) configActions
{
    [_floatView.commentsButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_floatView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_floatView.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCommentView)];
    [_floatView.commentView addGestureRecognizer:tap];
    
    [_contentFooter.qqButton addTarget:self action:@selector(qqButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFooter.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFooter.moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFooter.focusButton addTarget:self action:@selector(focusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFooter.wechatButton addTarget:self action:@selector(wechatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFooter.momentsButton addTarget:self action:@selector(momentsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) showCommentView
{
    if (!_commentView) {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"FeedDetailCommentView" owner:self options:nil] firstObject];
        [_commentView.cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_commentView.sendButton addTarget:self action:@selector(sendButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _commentView.frame = window.bounds;
    [window addSubview:_commentView];
    [_commentView.textView becomeFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void) cancelButtonTapped:(id)sender
{
    [_commentView.textView resignFirstResponder];
    [_commentView removeFromSuperview];
}

- (void) sendButtonTapped:(id)sender
{
    if (_commentView.textView.text.length == 0) {
        [XFToastView showTextToast:@"请输入评论！"];
        return;
    }
    NSDictionary *params = @{@"id":_feed.Id,
                             @"columnid":[XFUtil getCidWithColumnId:_feed.ColumnId],
                             @"content":_commentView.textView.text,
                             @"name":@"蓝柏林",
                             @"pid":@"0",
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:AddComment
     params:params parser:[XFHttpResponseParser sharedParser].SubscriptionParser progress:nil
     success:^(id response) {
         _commentView.textView.text = @"";
         [_commentView.textView resignFirstResponder];
         [_commentView removeFromSuperview];
         [XFToastView showTextToast:@"评论成功！"];
         _floatView.commentCountLabel.text = [NSString stringWithFormat:@"%zi",[_floatView.commentCountLabel.text integerValue] + 1];
     } failure:^(NSError *error) {
         
     }];
}

- (void) commentButtonAction:(id)sender
{
    CommentsViewController *controller = [CommentsViewController new];
    controller.Id = self.Id;
    controller.ColumnId = self.ColumnId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) shareButtonAction:(id)sender
{
    ShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] firstObject];
    shareView.cid = self.Cid;
    shareView.infoId = _feed.Id;
    shareView.webPageUrl = _feed.ShareUrl;
    shareView.feedName = _feed.Name;
    shareView.feedDescription = _feed.Description;
    shareView.shareImageUrl = self.shareImageUrl;
    [shareView showWithOptions:XFWeChatFriend|XFWeChatMoments|XFQQ|XFQZone|XFWeibo];
}

- (void) collectButtonAction:(id)sender
{
    if ([_feed.IsFavorite isEqualToString:@"0"]) {
        [[XFCommonFunc sharedInstance]
         addFavoriteInfoWithCid:self.Cid infoId:_feed.Id
         success:^{
             _feed.IsFavorite = @"1";
             [_floatView.collectButton setImage:[UIImage imageNamed:@"ic_find_more_collect_seleted"] forState:UIControlStateNormal];
         } failure:^(NSError *error){
             
         }];
    }else{
        [[XFCommonFunc sharedInstance]
         deleteFavoriteInfoWithInfoId:_feed.Id
         success:^{
             _feed.IsFavorite = @"0";
             [_floatView.collectButton setImage:[UIImage imageNamed:@"ic_find_more_collect"] forState:UIControlStateNormal];
         } failure:^(NSError *error){
             
         }];
    }
}

- (void) qqButtonAction:(id)sender
{
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.title = _feed.Name;
        messageObject.text = _feed.Description;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                             shareObjectWithTitle:_feed.Name descr:_feed.Description
                                             thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
        shareObject.webpageUrl = _feed.ShareUrl;
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
}

- (void) likeButtonAction:(id)sender
{
    if ([_feed.IsLike isEqualToString:@"0"]) {
        [[XFCommonFunc sharedInstance]
         infoLikeWithCid:self.Cid infoId:_feed.Id
         success:^{
             [XFToastView showTextToast:@"点赞成功！"];
             [_contentFooter.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
             _contentFooter.likeCountLabel.text = [NSString stringWithFormat:@"%zi", _contentFooter.likeCountLabel.text.integerValue + 1];
             _contentFooter.likeCountLabel.textColor = [UIColor colorWithHexValue:0xf46036 alpha:1.0f];
         } failure:^(NSError *error){
             [XFToastView showTextToast:@"点赞失败！"];
         }];
    }else{
        [XFToastView showTextToast:@"已经点过赞！"];
    }
}

- (void) moreButtonAction:(id)sender
{
    ShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] firstObject];
    shareView.cid = self.Cid;
    shareView.infoId = _feed.Id;
    shareView.webPageUrl = _feed.ShareUrl;
    shareView.feedName = _feed.Name;
    shareView.feedDescription = _feed.Description;
    shareView.shareImageUrl = self.shareImageUrl;
    [shareView showWithOptions:XFWeChatFriend|XFWeChatMoments|XFQQ|XFQZone|XFWeibo];
}

- (void) focusButtonAction:(id)sender
{
    if([_feed.IsFavoriteAdmin isEqualToString:@"0"]){
        [[XFCommonFunc sharedInstance]
         subscribeInfoWithCid:self.Cid infoId:_feed.Id adminId:_feed.AuthorInfo.Id
         success:^{
             _feed.IsFavoriteAdmin = @"1";
             [XFToastView showTextToast:@"关注成功！"];
             [_contentFooter.focusButton setTitle:@"已关注" forState:UIControlStateNormal];
         } failure:^(NSError *error){
             [XFToastView showTextToast:@"关注失败！"];
         }];
    }else{
        [[XFCommonFunc sharedInstance]
         unsubscribeInfoWithAdminId:_feed.AuthorInfo.Id
         success:^{
             _feed.IsFavoriteAdmin = @"0";
             [XFToastView showTextToast:@"取消关注！"];
             [_contentFooter.focusButton setTitle:@"关注" forState:UIControlStateNormal];
         } failure:^(NSError *error){
             [XFToastView showTextToast:@"取消关注失败！"];
         }];
    }
}

- (void) wechatButtonAction:(id)sender
{
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.title = _feed.Name;
        messageObject.text = _feed.Description;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                             shareObjectWithTitle:_feed.Name descr:_feed.Description
                                             thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
        shareObject.webpageUrl = _feed.ShareUrl;
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
}

- (void) momentsButtonAction:(id)sender
{
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.title = _feed.Name;
        messageObject.text = _feed.Description;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                             shareObjectWithTitle:_feed.Name descr:_feed.Description
                                             thumImage:[XFUtil getShareThumbnail:self.shareImageUrl]];
        shareObject.webpageUrl = _feed.ShareUrl;
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
}

- (void) videoAction:(id)sender
{
    if (_feed.PlayerUrl.length > 0) {
        KRVideoPlayerController *videoViewController = [[KRVideoPlayerController alloc]init];
        videoViewController.videoUrl = [NSURL URLWithString:_feed.PlayerUrl];
        [self.navigationController presentViewController:videoViewController animated:YES completion:nil];
    }
}

- (UITableView *) tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"RecommendTableViewCell" bundle:nil] forCellReuseIdentifier:recommendTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"FeedTableViewSectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:feedTableViewSectionHeaderIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_recommends.count > indexPath.row) {
            RecommendItem *recommend = [_recommends objectAtIndex:indexPath.row];
            RecommendTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:recommendTableViewCellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = recommend.Name;
            cell.tagLabel.text = recommend.Tag;
            cell.shortNameLabel.text = recommend.ShortName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.infoImageView sd_setImageWithURL:[NSURL URLWithString:recommend.ImageUrl] placeholderImage:[UIImage imageNamed:@"pic_find_new_1_load"]];
            return cell;
        }
    }else if(indexPath.section == 1){
        if (_comments.count > indexPath.row) {
            CommentItem *comment = [_comments objectAtIndex:indexPath.row];
            CommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:commentTableViewCellIdentifier forIndexPath:indexPath];
            cell.dateLabel.text = comment.CreateDate;
            cell.nameLabel.text = comment.NickName;
            cell.commentCountLabel.text = comment.Comment;
            cell.likeCountLabel.text = comment.Like;
            cell.commentLabel.text = comment.Content;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.index = indexPath.row;
            cell.delegate = self;
            if ([comment.IsLike isEqualToString:@"0"]) {
                [cell.likeButton setImage:[UIImage imageNamed:@"comment_ic_like_default"] forState:UIControlStateNormal];
                cell.likeCountLabel.textColor = [UIColor colorWithHexValue:0x8c8c8c alpha:1.0f];
            }else{
                [cell.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
                cell.likeCountLabel.textColor = [UIColor colorWithHexValue:0xf46036 alpha:1.0f];
            }
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:comment.UserPhoto] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
            return cell;
        }
    }
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FeedTableViewSectionHeader *sectionHeader = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:feedTableViewSectionHeaderIdentifier];
    if (section == 0) {
        sectionHeader.sectionLabel.text = @"相关推荐";
    }else if (section == 1){
        sectionHeader.sectionLabel.text = @"最新评论";
    }
    return sectionHeader;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [self.dataSource objectAtIndex:section];
    return items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_recommends.count > indexPath.row) {
            return 98.0f;
        }
    }else if(indexPath.section == 1){
        if (_comments.count > indexPath.row) {
            CommentItem *comment = [_comments objectAtIndex:indexPath.row];
            if (!comment.cellHeight) {
                CGSize contentSize = [comment.Content sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 82.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
                comment.cellHeight = contentSize.height + 51.0f;
            }
            return comment.cellHeight;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RecommendItem *recommend = [_recommends objectAtIndex:indexPath.row];
        FeedDetailViewController *controller = [FeedDetailViewController new];
        controller.ColumnId = recommend.ColumnId;
        controller.Id = recommend.Id;
        controller.Cid = [XFUtil getCidWithColumnId:recommend.ColumnId];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void) likeCommentWithIndex:(NSInteger)index success:(void (^)())success
{
    CommentItem *comment = [_comments objectAtIndex:index];
    if ([comment.IsLike isEqualToString:@"0"]) {
        [[XFCommonFunc sharedInstance]
         commentLikeWithCommentId:comment.Id
         success:^{
             comment.IsLike = @"1";
             if (success) {
                 success();
             }
         } failure:^(NSError *error) {
             [XFToastView showTextToast:@"点赞失败！"];
         }];
    }else{
        [XFToastView showTextToast:@"已经点赞了！"];
    }
}
@end
