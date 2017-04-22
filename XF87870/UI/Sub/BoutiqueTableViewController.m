//
//  BoutiqueTableViewController.m
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BoutiqueTableViewController.h"
#import "BoutiqueInfoItem.h"
#import "BoutiqueTableViewCell.h"
#import "FeedDetailViewController.h"

@interface BoutiqueTableViewController ()<BoutiqueTableViewCellProtocol>

@end

@implementation BoutiqueTableViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"BoutiqueTableViewCell";
    self.tableViewIdentifier = @"BoutiqueTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [self.tableView.mj_header beginRefreshing];
}

- (void) loadData:(void(^)(void)) completion
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"cid":self.cid};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:BoutiqueInfo
     params:params parser:[XFHttpResponseParser sharedParser].BoutiqueInfoParser progress:nil
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

- (void)showBoutiqueDetail:(NSInteger)index
{
    BoutiqueInfoItem *item = [self.dataSource objectAtIndex:index];
    FeedDetailViewController *controller = [FeedDetailViewController new];
    controller.ColumnId = item.ColumnId;
    controller.Id = item.Id;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        BoutiqueInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
        BoutiqueTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",item.ImgUrl,item.Img]] placeholderImage:[UIImage imageNamed:@"pic_banner_load"]];
        cell.titleLabel.text = item.Name;
        cell.contentLabel.text = item.Description;
        cell.dateLabel.text = item.CreateDate;
        cell.index = indexPath.row;
        cell.delegate = self;
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    BoutiqueInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
    FeedDetailViewController *controller = [FeedDetailViewController new];
    controller.ColumnId = item.ColumnId;
    controller.Id = item.Id;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        BoutiqueInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
        if (!item.cellHeight) {
            NSMutableDictionary *attribute1 = [[NSMutableDictionary alloc] init];
            [attribute1 setObject:[UIFont systemFontOfSize:17.0f] forKey:NSFontAttributeName];
            CGSize size1 = [item.Name sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 30.0f, FLT_MAX) Attributes:attribute1];
            
            NSMutableDictionary *attribute2 = [[NSMutableDictionary alloc] init];
            [attribute2 setObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName];
            CGSize size2 = [item.Description sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 30.0f, FLT_MAX) Attributes:attribute2];
            
            item.cellHeight = size1.height + size2.height + 280.0f;
        }
        return item.cellHeight;
    }else{
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

@end
