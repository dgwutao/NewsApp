//
//  SearchViewController.m
//  XF87870
//
//  Created by xf on 2016/11/25.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHeaderView.h"
#import "SearchGuideView.h"
#import "SearchHistoryTableViewHeader.h"
#import "SearchhistoryTableViewCell.h"
#import "SearchTableViewCell.h"
#import "FindListItem.h"
#import "FeedDetailViewController.h"

static NSString *searchHistoryTableViewCellIdentifier = @"SearchHistoryTableViewCellIdentifier";
static NSString *searchHistoryPath = @"com.87870.searchHistory";

@interface SearchViewController ()<UITextFieldDelegate,SearchHistoryTableViewCellProtocol>
{
    SearchHeaderView *_headerView;
    SearchGuideView *_guideView;
    BOOL _keyboardShown;
    NSMutableArray *_searchHistroy;
    UITapGestureRecognizer *_tapToHide1;
    UITapGestureRecognizer *_tapToHide2;
}
@property (strong, nonatomic) UITableView *searchHistoryTableView;
@end

@implementation SearchViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"SearchTableViewCell";
    self.tableViewIdentifier = @"SearchTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self setRightNavItemWithTitle:@"取消"];
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"SearchHeaderView" owner:self options:nil] firstObject];
    _headerView.textField.delegate = self;
    self.navigationItem.titleView = _headerView;
    _guideView = [[[NSBundle mainBundle] loadNibNamed:@"SearchGuideView" owner:self options:nil] firstObject];
    _guideView.frame = CGRectMake(0, 100, SCREEN_WIDTH, _guideView.frame.size.height);
    [self.view addSubview:_guideView];
    
    [_headerView.textField addTarget:self
                               action:@selector(textFieldDidChanged:)
                     forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.searchHistoryTableView];
    _searchHistroy = [NSMutableArray new];
    NSArray *searchHistoryInPlist = [[NSUserDefaults standardUserDefaults]objectForKey:searchHistoryPath];
    if (searchHistoryInPlist.count > 0) {
        [_searchHistroy addObjectsFromArray:searchHistoryInPlist];
    }
    
    _tapToHide1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    _tapToHide2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
}

- (void)textFieldDidChanged:(id)sender
{
    if (_headerView.textField.text.length > 0) {
        [_headerView.deleteButton setHidden:NO];
    }else{
        [_headerView.deleteButton setHidden:YES];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:)  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name: UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name: UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardDidShow:(NSNotification*)notification
{
    _keyboardShown = YES;
    [self.tableView addGestureRecognizer:_tapToHide1];
    [self.searchHistoryTableView addGestureRecognizer:_tapToHide2];
}

- (void) keyboardDidHide
{
    _keyboardShown = NO;
    [self.tableView removeGestureRecognizer:_tapToHide1];
    [self.searchHistoryTableView removeGestureRecognizer:_tapToHide2];
    [self.searchHistoryTableView setHidden:YES];
}

- (void)rightItemAction{
    [_headerView.textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_searchHistroy.count > 0) {
        self.searchHistoryTableView.hidden = NO;
        [self.searchHistoryTableView reloadData];
        [_guideView removeFromSuperview];
        _guideView = nil;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_headerView.textField resignFirstResponder];
    if (_headerView.textField.text.length > 0) {
        [self.tableView.mj_header beginRefreshing];
    }
    return YES;
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

- (UITableView*) searchHistoryTableView
{
    if (!_searchHistoryTableView) {
        _searchHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 252) style:UITableViewStylePlain];
        [_searchHistoryTableView registerNib:[UINib nibWithNibName:@"SearchHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:searchHistoryTableViewCellIdentifier];
        _searchHistoryTableView.backgroundColor = [UIColor whiteColor];
        _searchHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        SearchHistoryTableViewHeader *searchHeader = [[[NSBundle mainBundle] loadNibNamed:@"SearchHistoryTableViewHeader" owner:self options:nil] firstObject];
        [searchHeader.clearButton addTarget:self action:@selector(clearSearchHistory) forControlEvents:UIControlEventTouchUpInside];
        _searchHistoryTableView.tableHeaderView = searchHeader;
        _searchHistoryTableView.delegate = self;
        _searchHistoryTableView.dataSource = self;
        _searchHistoryTableView.hidden = YES;
        _searchHistoryTableView.bounces = NO;
    }
    return _searchHistoryTableView;
}

- (void)pullDownRefresh:(void(^)(void)) completion
{
    self.pageIndex = 1;
    [self search:completion];
}

- (void)pullUpRefresh:(void(^)(void)) completion
{
    self.pageIndex++;
    [self search:completion];
}

- (void)search:(void(^)(void)) completion
{
    NSString *keyword = _headerView.textField.text;
    if (keyword.length < 1) return;
    if ([_searchHistroy containsObject:keyword]) {
        [_searchHistroy removeObject:keyword];
        [_searchHistroy insertObject:keyword atIndex:0];
    }else{
        [_searchHistroy insertObject:keyword atIndex:0];
    }
    [[NSUserDefaults standardUserDefaults]setObject:_searchHistroy forKey:searchHistoryPath];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self hideKeyboard];
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"uid":DefaultUid,
                             @"keyword":keyword};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:FindInfo
     params:params parser:[XFHttpResponseParser sharedParser].FindInfoParser progress:nil
     success:^(id response) {
         if (_guideView) {
             [_guideView removeFromSuperview];
             _guideView = nil;
         }
         if (weakSelf.pageIndex == 1) {
             [weakSelf.dataSource removeAllObjects];
         }
         weakSelf.searchHistoryTableView.hidden = YES;
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
         if (weakSelf.pageIndex > 1) {
             weakSelf.pageIndex--;
         }
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _searchHistoryTableView) {
        if (_searchHistroy.count > indexPath.row) {
            NSString *keyword = [_searchHistroy objectAtIndex:indexPath.row];
            SearchHistoryTableViewCell *cell = [self.searchHistoryTableView dequeueReusableCellWithIdentifier:searchHistoryTableViewCellIdentifier forIndexPath:indexPath];
            cell.searchHistoryLabel.text = keyword;
            cell.index = indexPath.row;
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (tableView == _tableView){
        if (self.dataSource.count > indexPath.row) {
            FindListItem *item = [self.dataSource objectAtIndex:indexPath.row];
            SearchTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
            cell.tagLabel.text = item.Label;
            cell.titleLabel.text = item.Name;
            cell.sourceLabel.text = item.AuthorName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (item.ImageUrlList.count > 0) {
                [cell.searchImageView sd_setImageWithURL:[NSURL URLWithString:item.ImageUrlList.firstObject] placeholderImage:[UIImage imageNamed:@"pic_find_new_2_load"]];
            }else{
                cell.searchImageView.image = [UIImage imageNamed:@"pic_find_new_2_load"];
            }
        }
    }
    return [UITableViewCell new];
}

- (void) deleteIndividulSearchHitoryByIndex:(NSInteger)index
{
    NSString *keyword = [_searchHistroy objectAtIndex:index];
    if ([_searchHistroy containsObject:keyword]) {
        [_searchHistroy removeObject:keyword];
    }
    [[NSUserDefaults standardUserDefaults]setObject:_searchHistroy forKey:searchHistoryPath];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.searchHistoryTableView reloadData];
}

- (void) searchHistoryLabelTappedByIndex:(NSInteger)index
{
    NSString *keyword = [_searchHistroy objectAtIndex:index];
    if ([_searchHistroy containsObject:keyword]) {
        [_searchHistroy removeObject:keyword];
        [_searchHistroy insertObject:keyword atIndex:0];
    }else{
        [_searchHistroy insertObject:keyword atIndex:0];
    }
    [[NSUserDefaults standardUserDefaults]setObject:_searchHistroy forKey:searchHistoryPath];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _headerView.textField.text = keyword;
    [self.tableView.mj_header beginRefreshing];
}

- (void) hideKeyboard
{
    if (_keyboardShown) {
        [_headerView.textField resignFirstResponder];
    }
}

- (void) clearSearchHistory
{
    [_searchHistroy removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:_searchHistroy forKey:searchHistoryPath];
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.searchHistoryTableView.hidden = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView){
        if (self.dataSource.count > indexPath.row) {
            FindListItem *item = [self.dataSource objectAtIndex:indexPath.row];
            FeedDetailViewController *controller = [FeedDetailViewController new];
            controller.ColumnId = item.ColumnId;
            controller.Id = item.Id;
            controller.Cid = [XFUtil getCidWithColumnId:item.ColumnId];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _searchHistoryTableView) {
        return 40.0f;
    }
    else if (tableView == _tableView){
        return 98.0f;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _searchHistoryTableView) {
        return _searchHistroy.count;
    }
    else if (tableView == _tableView){
        return self.dataSource.count;
    }
    return 0;
}

@end
