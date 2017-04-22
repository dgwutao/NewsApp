//
//  HardwareViewController.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "HardwareViewController.h"
#import "HardwareTableViewCell.h"

#import "BannerItem.h"
#import "FeedDetailViewController.h"
#import "HardwarecaItem.h"
#import "HardwareInfoItem.h"
#import "SearchViewController.h"



static NSString *cellectioncellId=@"cellectioncellId";

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width



@interface HardwareViewController ()
@property (strong, nonatomic) XFBannerView *xfBanner;
@property (strong,nonatomic) UIView *subTypeView;


@property (strong,nonatomic) NSArray *subTypeArray;
@property (strong,nonatomic) NSArray *infoArray;

@property (strong,nonatomic) NSString *currentCid;




@end

@implementation HardwareViewController

- (void)loadView{
    [super loadView];
    
    self.tableViewCellRegister = @"HardwareTableViewCell";
    self.tableViewIdentifier = @"HardwareTableViewCellIdentifier";
    self.navbarTranslucent = YES;
    //    self.bannerOption = XFMainBanner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setRightNavItemWithImage:@"ic_nav_search"];
    
    [self loadBannerWithCid:@"3"];
    
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    取消cell的选中状态
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    
}



-(void) rightItemAction{
    SearchViewController *controller = [SearchViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)pullDownRefresh:(void(^)(void)) completion
{
}

- (void)pullUpRefresh:(void(^)(void)) completion
{
    self.pageIndex=self.pageIndex+1;

    [self loadinfoData:_currentCid pageIndex:self.pageIndex];

}
-(void) loadinfoData:(NSString *)cid pageIndex:(NSInteger)pageIdx{
    
    __weak typeof (self.tableView) weakTableView = self.tableView;
    
    
    NSDictionary *params2 = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                              @"pageindex":[NSString stringWithFormat:@"%zi",pageIdx],
                              @"sort":@"recent",
                              @"cid":cid,
                              @"uid":@"0"};
    //                              @"price":@"",
    //                              @"keyword":@""};
    [self.sessionManager sendGetHttpRequestWithUrl:HardwareInfo params:params2 parser:[XFHttpResponseParser sharedParser].HardwareInfoParser progress:nil
                                           success:^(id response) {
                                               NSLog(@"%@",response);
                                               
                                               _infoArray=[NSArray arrayWithArray:response];
                                               
                                               
                                               [weakTableView reloadData];
                                               
                                               
                                               
                                               
                                               
                                           } failure:^(NSError *error) {
                                               NSLog(@"%@",error);
                                               
                                           }];
    
}


- (void) loadData
{
    _subTypeArray=[[NSArray alloc] init];
    
    _infoArray=[[NSArray alloc] init];
    
    
    __weak typeof (self.collectionView) weakcollectionView=self.collectionView;
    
    [self.sessionManager sendGetHttpRequestWithUrl:HardwarecaInfo params:@{} parser:[XFHttpResponseParser sharedParser].HardwarecaInfoParser progress:nil
                                           success:^(id response) {
                                               NSLog(@"%@",response);
                                               
                                               _subTypeArray=[NSArray arrayWithArray:response];
                                               
                                               HardwarecaItem *item=[_subTypeArray objectAtIndex:0];
                                               
                                               [weakcollectionView reloadData];
                                               
                                               [self loadinfoData:item.Cid pageIndex:self.pageIndex];
                                               _currentCid=item.Cid;
                                               
                                           } failure:^(NSError *error) {
                                               NSLog(@"%@",error);
                                               
                                           }];
}
- (UIView *)subTypeView
{
    if (!_subTypeView) {
        _subTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 251, self.view.frame.size.width, 40)];
        _subTypeView.backgroundColor=[UIColor whiteColor];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 0.5)];
        [lineView setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1]];
        [_subTypeView addSubview:lineView];
        
        
        
        
        [self loadCollectionView:_subTypeView];
    }
    return _subTypeView;
}


- (XFBannerView*)xfBanner
{
    if (!_xfBanner) {
        __weak typeof (self) weakSelf = self;
        _xfBanner = [XFBannerView initBannerViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 235) imageLinkURL:@[@""] subtitleArray:nil placeHoderImageName:@"pic_banner_load" bannerTapped:^(NSInteger index) {
            if (weakSelf.banners.count > index) {
                BannerItem *banner = [weakSelf.banners objectAtIndex:index];
                if ([banner.Type isEqualToString:@"1"]) {
                    NSString *columnId;
                    if ([banner.ColumnId isEqualToString:@"1"]) {
                        columnId = @"1_0";
                    }else if([banner.ColumnId isEqualToString:@"2"]){
                        columnId = @"2_0";
                    }
                    FeedDetailViewController *controller = [FeedDetailViewController new];
                    controller.ColumnId = columnId;
                    controller.Id = banner.Id;
                    controller.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                }else if ([banner.Type isEqualToString:@"2"]) {
                    
                }
            }
        }];
    }
    return _xfBanner;
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStylePlain];
        if ([self.tableViewCellRegister isKindOfClass:[NSString class]]) {
            [_tableView registerNib:[UINib nibWithNibName:self.tableViewCellRegister bundle:nil] forCellReuseIdentifier:self.tableViewIdentifier];
        }else if([self.tableViewCellRegister isKindOfClass:[UITableViewCell class]]){
            [_tableView registerClass:[self.tableViewCellRegister class] forCellReuseIdentifier:self.tableViewIdentifier];
        }
        _tableView.backgroundColor = [UIColor whiteColor];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//add sub type of Hardware
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250.0f + 40.0f)];
        [view addSubview:self.xfBanner];
        [view addSubview:self.subTypeView];
        
        [self.xfBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top);
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.height.mas_equalTo(235.0f);
        }];
        
        [self.subTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.xfBanner.mas_bottom).offset(15.0f);
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.height.mas_equalTo(40.0f);
        }];
        self.tableView.tableHeaderView = view;
        
        
    }
    return _tableView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HardwareTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
    HardwareInfoItem *item = [_infoArray objectAtIndex:indexPath.row];
    
    //    cell.delegate = self;
    [cell setData:item];
    
    
    //    [cell load];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HardwareInfoItem *item = [_infoArray objectAtIndex:indexPath.row];
    
    FeedDetailViewController *controller = [FeedDetailViewController new];
    controller.ColumnId = item.ColumnId;
    controller.Id = item.Id;
    controller.Cid = [XFUtil getCidWithColumnId:item.ColumnId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArray.count;
    return 8;
    return self.dataSource.count;
}



-(void)loadCollectionView:(UIView *)baseView{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kScreenWidth/3-8, 50);
    //    flowLayout.itemSize = CGSizeMake(67, 81);
    
    
    
    //        flowLayout.sectionInset = UIEdgeInsetsMake(3.0, 8.0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.minimumLineSpacing=5.0f;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor=[UIColor clearColor];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellectioncellId];
    
    
    [baseView addSubview:_collectionView];
    
    
    
}
#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _subTypeArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId=@"CellCollectionId";
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (nil==cell) {
        cell=[[UICollectionViewCell alloc] init];
        
    }
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 40)];
    [label setText:@"VR硬件分类"];
    
    HardwarecaItem *item=[_subTypeArray objectAtIndex:indexPath.row];
    NSString *name=item.Name;
    [label setText:name];
    
    
    
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTag:10000];
    [cell addSubview:label];
    
    //    add short line
    
    UIView *shortlineView=[[UIView alloc] initWithFrame:CGRectMake(40, 38, kScreenWidth/3-80, 2)];
    [shortlineView setTag:10001];

    if (indexPath.row==0) {
        [shortlineView setBackgroundColor:[UIColor yellowColor]];

    }
    [cell addSubview:shortlineView];
    
    
    
    
    return cell;
    
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    
    for (UILabel *label in cell.subviews){
        if (label.tag==10000) {
            [label setTextColor:[UIColor grayColor]];
        }
    }
    
    for (UIView *view in cell.subviews){
        if (view.tag==10001) {
            [view setBackgroundColor:[UIColor clearColor]];
        }
    }
    
    
}


-(void)dismissFirstItem:(UICollectionView *)collectionView{
    
    NSIndexPath *idxPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    
    UICollectionViewCell *cell2=[collectionView cellForItemAtIndexPath:idxPath];
    
    if (cell2) {
        for (UIView *view in cell2.subviews){
            if (view.tag==10001) {
                [view setBackgroundColor:[UIColor clearColor]];
            }
        }

    }
}






- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UICollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    
    
    for (UILabel *label in cell.subviews){
        if (label.tag==10000) {
            [label setTextColor:[UIColor blackColor]];
        }
    }
    
    
    [self dismissFirstItem:collectionView];
    
    
    for (UIView *view in cell.subviews){
        if (view.tag==10001) {
            [view setBackgroundColor:[UIColor yellowColor]];
        }
    }
    
    HardwarecaItem *item=[_subTypeArray objectAtIndex:indexPath.row];
    
    self.pageIndex=1;
    [self loadinfoData:item.Cid pageIndex:self.pageIndex];
    
}


@end
