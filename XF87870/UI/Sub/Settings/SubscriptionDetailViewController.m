//
//  SubscriptionDetailViewController.m
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubscriptionDetailViewController.h"
#import "SubscriptionDetailItem.h"
#import "SubscriptionDetailTableViewCell.h"
#import "SubscriptionDetailHeaderView.h"
#import "FeedDetailViewController.h"

@interface SubscriptionDetailViewController ()
{
    BOOL _isOperating;
}
@property (strong, nonatomic) SubscriptionDetailHeaderView *headerView;
@end

@implementation SubscriptionDetailViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"SubscriptionDetailTableViewCell";
    self.tableViewIdentifier = @"SubscriptionDetailTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订阅详情";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [super setRightNavItemWithTitle:@"取消关注"];
    [self.tableView.mj_header beginRefreshing];
}

- (void) rightItemAction
{
    if (_isOperating) return;
    _isOperating = YES;
    __weak typeof (self) weakSelf = self;
    [[XFCommonFunc sharedInstance]unsubscribeInfoWithAdminId:self.subcription.AdminId success:^{
        [XFToastView showTextToast:@"已取消订阅"];
        _isOperating = NO;
        weakSelf.navigationItem.rightBarButtonItem = nil;
    } failure:^(NSError *error) {
        _isOperating = NO;
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

- (void)loadData:(void(^)(void)) completion
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"adminid":self.subcription.AdminId};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:FavoriteAdminSendInfo
     params:params parser:[XFHttpResponseParser sharedParser].SubscriptionDetailParser progress:nil
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

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:self.tableViewCellRegister bundle:nil] forCellReuseIdentifier:self.tableViewIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (SubscriptionDetailHeaderView*)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"SubscriptionDetailHeaderView" owner:self options:nil] firstObject];
        _headerView.nameLabel.text = self.subcription.Name;
        _headerView.followerCountLabel.text = [NSString stringWithFormat:@"%@关注",self.subcription.FavoriteNumber];
        _headerView.postCountLabel.text = [NSString stringWithFormat:@"%@篇发布",self.subcription.InfoNumber];
        _headerView.descriptionLabel.text = self.subcription.Description;
        [_headerView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.subcription.ImageUrl] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
    }
    return _headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataSource.count > indexPath.row) {
        SubscriptionDetailItem *item = [self.dataSource objectAtIndex:indexPath.row];
        SubscriptionDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shortNameLabel.text = item.ShortName;
        cell.titleLabel.text = item.Name;
        cell.tagLabel.text = item.Tag;
        [cell.infoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",item.ImgUrl,item.Img]] placeholderImage:[UIImage imageNamed:@"pic_find_new_1_load"]];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > indexPath.row) {
        SubscriptionDetailItem *item = [self.dataSource objectAtIndex:indexPath.row];
        FeedDetailViewController *controller = [FeedDetailViewController new];
        controller.ColumnId = item.ColumnId;
        controller.Id = item.Id;
        controller.Cid = [XFUtil getCidWithColumnId:item.ColumnId];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

@end
