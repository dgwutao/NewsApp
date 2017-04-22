//
//  MyMessageViewController.m
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommentInfoItem.h"
#import "MyCommentTableViewCell.h"
#import "FeedDetailViewController.h"

@interface MyCommentViewController ()<MyCommentTableViewCellDelegate>

@end

@implementation MyCommentViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"MyCommentTableViewCell";
    self.tableViewIdentifier = @"MyCommentTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的评论";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData:(void(^)(void)) completion
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"sort":@"recent",
                             @"uid":DefaultUid};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:MyCommentInfo
     params:params parser:[XFHttpResponseParser sharedParser].MyCommentParser progress:nil
     success:^(id response) {
         if (weakSelf.pageIndex == 1) {
             [weakSelf.dataSource removeAllObjects];
         }
         NSArray *array = (NSArray*)response;
         [weakSelf.dataSource addObjectsFromArray:array];
         [weakSelf.tableView reloadData];
         if (completion) {
             completion();
         }
     } failure:^(NSError *error) {
         if (weakSelf.pageIndex > 1) {
             weakSelf.pageIndex--;
         }
         if (completion) {
             completion();
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
        [_tableView registerNib:[UINib nibWithNibName:self.tableViewCellRegister bundle:nil] forCellReuseIdentifier:self.tableViewIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > indexPath.row) {
        MyCommentInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
        NSDictionary *params = @{@"id":item.Id,
                                 @"uid":DefaultUid};
        __weak typeof (self) weakSelf = self;
        [self.sessionManager
         sendGetHttpRequestWithUrl:DeleteComment
         params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
         success:^(id response) {
             [weakSelf.dataSource removeObject:item];
             [weakSelf.tableView reloadData];
         } failure:^(NSError *error) {
             
         }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        MyCommentInfoItem *comment = [self.dataSource objectAtIndex:indexPath.row];
        MyCommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dateLabel.text = comment.CreateDate;
        cell.nameLabel.text = comment.NickName;
        cell.contentLabel.text = comment.Content;
        [cell.infoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",comment.info.ImgUrl,comment.info.Img]] placeholderImage:[UIImage imageNamed:@"pic_find_new_2_load"]];
        cell.infoTitleLabel.text = comment.info.Name;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:comment.UserPhoto] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
        cell.index = indexPath.row;
        cell.delegate = self;
        return cell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        MyCommentInfoItem *comment = [self.dataSource objectAtIndex:indexPath.row];
        if (!comment.cellHeight) {
            CGSize contentSize = [comment.Content sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 82.0f, FLT_MAX) Attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
            comment.cellHeight = contentSize.height + 128.0f;
        }
        return comment.cellHeight;
    }
    return 0;
}

- (void)infoViewTapped:(NSInteger)index
{
    MyCommentInfoItem *item = [self.dataSource objectAtIndex:index];
    FeedDetailViewController *controller = [FeedDetailViewController new];
    controller.ColumnId = item.info.ColumnId;
    controller.Id = item.info.Id;
    controller.Cid = [XFUtil getCidWithColumnId:item.info.ColumnId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
