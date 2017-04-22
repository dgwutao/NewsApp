//
//  CollectionViewController.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionTableViewHeader.h"
#import "CollectionInfoTableViewCell.h"
#import "CollectionInfoItem.h"
#import "CollectionHardwareItem.h"
#import "FeedDetailViewController.h"

@interface CollectionViewController ()
@property (strong, nonatomic) CollectionTableViewHeader *headerView;
@end

@implementation CollectionViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"CollectionInfoTableViewCell";
    self.tableViewIdentifier = @"CollectionInfoTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [self.view addSubview:self.headerView];
    __weak typeof (self) weakSelf = self;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(40.0f);
    }];
    [self loadDataWithCid:@"1" complete:nil];
}

//cid 1发现 2游戏 3硬件
- (void)loadDataWithCid:(NSString*)cid complete:(void(^)(void)) completion
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"uid":DefaultUid,
                             @"cid":cid};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:FavoriteInfo
     params:params parser:[XFHttpResponseParser sharedParser].CollectionInfoParser progress:nil
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
         if (completion) {
             completion();
         }
     }];
}

- (void)pullDownRefresh:(NSString*)cid complete:(void(^)(void)) completion
{
    self.pageIndex = 1;
    [self loadDataWithCid:@"1" complete:completion];
}

- (void)pullUpRefresh:(NSString*)cid complete:(void(^)(void)) completion
{
    self.pageIndex++;
    [self loadDataWithCid:@"1" complete:completion];
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f - 40.0f) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:self.tableViewCellRegister bundle:nil] forCellReuseIdentifier:self.tableViewIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        CollectionInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
        __weak typeof (self) weakSelf = self;
        [[XFCommonFunc sharedInstance] deleteFavoriteInfoWithInfoId:item.Id success:^{
            [weakSelf.dataSource removeObject:item];
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        CollectionInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
        CollectionInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = item.Name;
        cell.tagLabel.text = item.Tag;
        cell.shortNameLabel.text = item.ShortName;
        [cell.infoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",item.ImgUrl,item.Img]] placeholderImage:[UIImage imageNamed:@"pic_find_new_1_load"]];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > indexPath.row) {
        CollectionInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
        FeedDetailViewController *controller = [FeedDetailViewController new];
        controller.ColumnId = item.ColumnId;
        controller.Id = item.Id;
        controller.Cid = [XFUtil getCidWithColumnId:item.ColumnId];
        controller.hidesBottomBarWhenPushed = YES;
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

- (CollectionTableViewHeader*) headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CollectionTableViewHeader" owner:self options:nil] firstObject];
        [_headerView.findButton addTarget:self action:@selector(findButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.hardwareButton addTarget:self action:@selector(hardwareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (void)findButtonTapped:(id)sender
{
    [self.headerView.findButton setTitleColor:[UIColor colorWithHexValue:0x323232 alpha:1.0f] forState:UIControlStateNormal];
    self.headerView.findButtonTagView.hidden = NO;
    [self.headerView.hardwareButton setTitleColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0f] forState:UIControlStateNormal];
    self.headerView.hardwareButtonTagView.hidden = YES;
}

- (void)hardwareButtonTapped:(id)sender
{
    [self.headerView.findButton setTitleColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0f] forState:UIControlStateNormal];
    self.headerView.findButtonTagView.hidden = YES;
    [self.headerView.hardwareButton setTitleColor:[UIColor colorWithHexValue:0x323232 alpha:1.0f] forState:UIControlStateNormal];
    self.headerView.hardwareButtonTagView.hidden = NO;
}
@end
