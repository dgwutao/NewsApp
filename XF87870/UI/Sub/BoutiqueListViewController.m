//
//  BoutiqueListViewController.m
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BoutiqueListViewController.h"
#import "BoutiqueListTableViewCell.h"
#import "SubBannerItem.h"
#import "BoutiqueTableViewController.h"

@interface BoutiqueListViewController ()

@end

@implementation BoutiqueListViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"BoutiqueListTableViewCell";
    self.tableViewIdentifier = @"BoutiqueListTableViewCellIdentifier";
    self.navbarTranslucent = NO;
    self.PullRefreshOptions = XFPullRefreshOptionPullDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"精品栏目";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [self.tableView.mj_header beginRefreshing];
}

- (void) loadData:(void(^)(void)) completion
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize]};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:BoutiquecaInfo
     params:params parser:[XFHttpResponseParser sharedParser].SubBannerParser progress:nil
     success:^(id response) {
         NSArray *array = (NSArray*)response;
         [weakSelf.dataSource removeAllObjects];
         [weakSelf.dataSource addObjectsFromArray:array];
         [weakSelf.tableView reloadData];
         if (completion) {
             completion();
         }
     } failure:^(NSError *error) {
         
     }];
}

- (void)pullDownRefresh:(void(^)(void)) completion
{
    [self loadData:completion];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        SubBannerItem *item = [self.dataSource objectAtIndex:indexPath.row];
        BoutiqueListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:item.ImageUrl] placeholderImage:[UIImage imageNamed:@"pic_column_load"]];
        cell.mainLabel.text = item.Name;
        cell.subLabel.text = item.ShortName;
        return cell;
    }
    return [UITableViewCell new];
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:self.tableViewCellRegister bundle:nil] forCellReuseIdentifier:self.tableViewIdentifier];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    SubBannerItem *item = [self.dataSource objectAtIndex:indexPath.row];
    BoutiqueTableViewController *controller = [BoutiqueTableViewController new];
    controller.cid = item.Id;
    controller.title = item.Name;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 173.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


@end
