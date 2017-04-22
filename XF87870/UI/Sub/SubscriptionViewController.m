//
//  SubscriptionViewController.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "SubscriptionTableViewCell.h"
#import "SubscriptionItem.h"
#import "SubscriptionDetailViewController.h"

@interface SubscriptionViewController ()

@end

@implementation SubscriptionViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"SubscriptionTableViewCell";
    self.tableViewIdentifier = @"SubscriptionTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订阅";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
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
                             @"uid":DefaultUid};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:FavoriteAdminInfo
     params:params parser:[XFHttpResponseParser sharedParser].SubscriptionParser progress:nil
     success:^(id response) {
         if (weakSelf.pageIndex == 1) {
             [weakSelf.dataSource removeAllObjects];
         }
         NSArray *array = (NSArray*)response;
         [weakSelf.dataSource removeAllObjects];
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        SubscriptionItem *item = [self.dataSource objectAtIndex:indexPath.row];
        SubscriptionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = item.Name;
        cell.descriptionLabel.text = item.Description;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.ImageUrl] placeholderImage:[UIImage imageNamed:DefaultAvatar]];
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    SubscriptionItem *item = [self.dataSource objectAtIndex:indexPath.row];
    SubscriptionDetailViewController *controller = [SubscriptionDetailViewController new];
    controller.subcription = item;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
@end
