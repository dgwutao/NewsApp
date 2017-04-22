//
//  CommentsViewController.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentItem.h"
#import "CommentTableViewCell.h"
#import "CommentReplyItem.h"
#import "commentTableViewCell_R.h"
#import "FeedDetailCommentView.h"

@interface CommentsViewController ()<CommentTableViewCellProtocol>

@property (strong, nonatomic) FeedDetailCommentView *commentView;
@end
static NSString *commentTableViewCellIdentifier = @"CommentTableViewCellIdentifier";
static NSString *commentTableViewCell_RIdentifier = @"CommentTableViewCell_RIdentifier";

@implementation CommentsViewController

- (void)loadView{
    [super loadView];
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部评论";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData:(void(^)(void)) completion{
    __weak typeof (self) weakSelf = self;
    NSDictionary *params = @{@"uid":DefaultUid,
                             @"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"sort":@"recent",
                             @"id":self.Id};
    [self.sessionManager
     sendGetHttpRequestWithUrl:CommentInfo
     params:params parser:[XFHttpResponseParser sharedParser].CommentInfoParser progress:nil
     success:^(id response) {
         if (weakSelf.pageIndex == 1) {
             [weakSelf.dataSource removeAllObjects];
         }
         NSArray *comments = (NSArray*)response;
         for (CommentItem *comment in comments) {
             [weakSelf.dataSource addObject:comment];
             if (comment.List.count > 0) {
                 [weakSelf.dataSource addObjectsFromArray:comment.List];
             }
         }
         [weakSelf.tableView reloadData];
         if (completion) {
             completion();
         }
     } failure:^(NSError *error) {
         if (completion) {
             completion();
         }
         if (weakSelf.pageIndex > 1) {
             weakSelf.pageIndex--;
         }
     }];
}

- (void)pullDownRefresh:(void(^)(void)) completion
{
    self.pageIndex = 1;
    [self loadData:completion];
}

- (void)pullUpRefresh:(void(^)(void)) completion
{
    self.pageIndex++;
    [self loadData:completion];
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell_R" bundle:nil] forCellReuseIdentifier:commentTableViewCell_RIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        id raw = [self.dataSource objectAtIndex:indexPath.row];
        if ([raw isKindOfClass:[CommentItem class]]) {
            CommentItem *comment = (CommentItem*)raw;
            CommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:commentTableViewCellIdentifier forIndexPath:indexPath];
            cell.dateLabel.text = comment.CreateDate;
            cell.nameLabel.text = comment.NickName;
            cell.commentCountLabel.text = [NSString stringWithFormat:@"%zi",comment.List.count];
            cell.likeCountLabel.text = comment.Like;
            cell.commentLabel.text = comment.Content;
            cell.index = indexPath.row;
            cell.delegate = self;
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:comment.UserPhoto] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
            if ([comment.IsLike isEqualToString:@"0"]) {
                [cell.likeButton setImage:[UIImage imageNamed:@"comment_ic_like_default"] forState:UIControlStateNormal];
                cell.likeCountLabel.textColor = [UIColor colorWithHexValue:0x8c8c8c alpha:1.0f];
            }else{
                [cell.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
                cell.likeCountLabel.textColor = [UIColor colorWithHexValue:0xf46036 alpha:1.0f];
            }
            if (![comment.Like isEqualToString:@"0"]) {
                cell.likeCountLabel.text = comment.Like;
            }else{
                cell.likeCountLabel.text = @"0";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else{
            CommentReplyItem *replay = (CommentReplyItem*)raw;
            CommentTableViewCell_R *cell = [self.tableView dequeueReusableCellWithIdentifier:commentTableViewCell_RIdentifier forIndexPath:indexPath];
            cell.nameLabel.text = replay.NickName;
            if (![replay.Like isEqualToString:@"0"]) {
                cell.likeCountLabel.text = replay.Like;
            }else{
                cell.likeCountLabel.text = @"0";
            }
            cell.commentLabel.text = replay.Content;
            cell.index = indexPath.row;
            cell.delegate = self;
            if ([replay.IsLike isEqualToString:@"0"]) {
                [cell.likeButton setImage:[UIImage imageNamed:@"comment_ic_like_default"] forState:UIControlStateNormal];
                cell.likeCountLabel.textColor = [UIColor colorWithHexValue:0x8c8c8c alpha:1.0f];
            }else{
                [cell.likeButton setImage:[UIImage imageNamed:@"comment_ic_like"] forState:UIControlStateNormal];
                cell.likeCountLabel.textColor = [UIColor colorWithHexValue:0xf46036 alpha:1.0f];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [UITableViewCell new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        id raw = [self.dataSource objectAtIndex:indexPath.row];
        if ([raw isKindOfClass:[CommentItem class]]) {
            CommentItem *comment = (CommentItem*)raw;
            if (!comment.cellHeight) {
                CGSize contentSize = [comment.Content sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 82.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
                comment.cellHeight = contentSize.height + 51.0f;
            }
            return comment.cellHeight;
        }else{
            CommentReplyItem *replay = (CommentReplyItem*)raw;
            if (!replay.cellHeight) {
                CGSize contentSize = [replay.Content sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 91.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
                replay.cellHeight = contentSize.height + 41.0f;
            }
            return replay.cellHeight;
        }
    }
    return 0;
}

- (void) addCommentWithIndex:(NSInteger)index
{
    self.commentView.sendButton.tag = index;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.commentView.frame = window.bounds;
    [window addSubview:_commentView];
    [self.commentView.textView becomeFirstResponder];
}

- (void) likeCommentWithIndex:(NSInteger)index success:(void (^)())success
{
    CommentReplyItem *comment = [self.dataSource objectAtIndex:index];
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
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    CommentReplyItem *comment = [self.dataSource objectAtIndex:index];
    __weak typeof (self) weakSelf = self;
    NSDictionary *params = @{@"id":self.Id,
                             @"columnid":[XFUtil getCidWithColumnId:self.ColumnId],
                             @"content":_commentView.textView.text,
                             @"name":@"蓝柏林",
                             @"pid":comment.Id,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:AddComment
     params:params parser:[XFHttpResponseParser sharedParser].SubscriptionParser progress:nil
     success:^(id response) {
         weakSelf.commentView.textView.text = @"";
         [weakSelf.commentView.textView resignFirstResponder];
         [weakSelf.commentView removeFromSuperview];
         [XFToastView showTextToast:@"评论成功！"];
         [weakSelf loadData:nil];
     } failure:^(NSError *error) {
         
     }];
}

- (FeedDetailCommentView*) commentView
{
    if (!_commentView) {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"FeedDetailCommentView" owner:self options:nil] firstObject];
        [_commentView.cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_commentView.sendButton addTarget:self action:@selector(sendButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentView;
}

@end
