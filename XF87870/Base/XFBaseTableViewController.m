//
//  XFBaseTableViewController.m
//  XF87870
//
//  Created by xf on 2016/11/10.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseTableViewController.h"
#import "BannerItem.h"
#import "SubBannerItem.h"
#import "BannerView.h"
#import "BoutiqueListViewController.h"
#import "BoutiqueTableViewController.h"
#import "FeedDetailViewController.h"

@interface XFBaseTableViewController ()
@property (strong, nonatomic) BannerView *subHeaderView;
@property (assign, nonatomic) CGFloat alpha;
@property (strong, nonatomic) XFBannerView *xfBanner;
@end

@implementation XFBaseTableViewController

- (void)loadView{
    [super loadView];
    self.alpha = 0;
    self.pageSize = 20;
    self.pageIndex = 1;
    self.dataSource = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bannerOption = XFMainBanner;
    self.PullRefreshOptions = XFPullRefreshOptionPullUp | XFPullRefreshOptionPullDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    if (self.navbarTranslucent) {
        UIImageView *coverView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_find_barcover"]];
        coverView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64.0f);
        coverView.alpha = .5f;
        [self.view addSubview:coverView];
    }
    
    __weak typeof (self) weakSelf = self;
    if (self.PullRefreshOptions & XFPullRefreshOptionPullDown) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf pullDownRefresh:^{[weakSelf.tableView.mj_header endRefreshing];}];
        }];
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    }
    if (self.PullRefreshOptions & XFPullRefreshOptionPullUp) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf pullUpRefresh:^{[weakSelf.tableView.mj_footer endRefreshing];}];
        }];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navbarTranslucent) {
        self.navigationController.navigationBar.translucent = YES;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:self.alpha];
    }else{
        self.navigationController.navigationBar.translucent = NO;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    }
}

#pragma Abstract method
- (void)pullDownRefresh:(void(^)(void)) completion{}

- (void)pullUpRefresh:(void(^)(void)) completion{}

//cid 1发现 2游戏 3硬件
//返回信息list type=>1代表详情页 2代表列表页 3代表广告链接
//columnid 对应详细跳转栏目 type=1或者2时有效
//id 对应详细跳转详情页 type=1时有效
//url 对应外链 type=3时有效

-(void) loadBannerWithCid:(NSString*)cid
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%ld",(long)self.pageSize],
                             @"cid":cid};
    [self.sessionManager sendGetHttpRequestWithUrl:ImageSwitchInfo params:params parser:[XFHttpResponseParser sharedParser].ImageSwitchInfoParser progress:nil success:^(id response) {
        NSArray *banners = (NSArray*)response;
        self.banners = banners;
        NSMutableArray *imageUrls = [NSMutableArray arrayWithCapacity:banners.count];
        for (BannerItem *banner in banners) {
            [imageUrls addObject:banner.ImageUrl];
        }
        [self.xfBanner refreshBannerWithImageUrls:imageUrls];
    } failure:^(NSError *error) {
        
    }];
}

//返回信息list type=>1代表详情页 2代表列表页 3代表广告链接
//columnid 对应详细跳转栏目 type=1或者2时有效
//id 对应详细跳转详情页 type=1时有效
//url 对应外链 type=3时有效

-(void)loadSubBannerWithUrl:(NSString*)url andTitle:(NSString*)title
{
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize]};
    [self.sessionManager sendGetHttpRequestWithUrl:url params:params parser:[XFHttpResponseParser sharedParser].SubBannerParser progress:nil success:^(id response) {
        NSArray *subBanners = (NSArray*)response;
        self.subBanners = subBanners;
        self.subHeaderView.titleLabel.text = title;
        for (UIView *view in self.subHeaderView.scrollView.subviews) {
            [view removeFromSuperview];
        }
        __weak typeof (self.subHeaderView.scrollView) weakScrollView = self.subHeaderView.scrollView;
        CGFloat contentSizeWidth = 0;
        
        for (NSInteger i = 0;i < subBanners.count; i++){
            SubBannerItem *subBanner = [subBanners objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.layer.cornerRadius = 6.0f;
            imageView.layer.masksToBounds = YES;
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(subBannerTapped:)];
            [imageView addGestureRecognizer:tap];
            [imageView sd_setImageWithURL:[NSURL URLWithString:subBanner.ImageUrl] placeholderImage:[UIImage imageNamed:@"pic_column_load"]];
            [self.subHeaderView.scrollView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakScrollView.mas_top);
                make.left.equalTo(weakScrollView.mas_left).offset(12 + contentSizeWidth);
                make.width.mas_equalTo(198);
                make.height.mas_equalTo(98);
            }];
            contentSizeWidth += 198;
            contentSizeWidth += 12;
            UILabel *label = [[UILabel alloc]init];
            label.text = subBanner.Name;
            label.font = [UIFont systemFontOfSize:12.0f];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            [self.subHeaderView.scrollView addSubview:label];
            
            __weak typeof (imageView) weakImageView = imageView;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakImageView.mas_bottom).offset(-8);
                make.left.equalTo(weakImageView.mas_left).offset(8);
                make.right.equalTo(weakImageView.mas_right).offset(-8);
            }];
        }
        contentSizeWidth += 12;
        self.subHeaderView.scrollView.contentSize = CGSizeMake(contentSizeWidth, 0);
    } failure:^(NSError *error) {
        
    }];
}

- (void) subBannerTapped:(id)sender
{
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView*)tapGesture.view;
    NSInteger index = imageView.tag;
    SubBannerItem *subBanner = [self.subBanners objectAtIndex:index];
    BoutiqueTableViewController *controller = [BoutiqueTableViewController new];
    controller.cid = subBanner.Id;
    controller.title = subBanner.Name;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.navbarTranslucent) return;
    CGFloat contentOffset = scrollView.contentOffset.y;
    self.alpha = contentOffset / 64;
    if (self.alpha > 1.0) {
        self.alpha = 1.0;
    }
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:self.alpha];
}

- (BannerView*)subHeaderView
{
    if (!_subHeaderView) {
        _subHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"BannerView" owner:self options:nil] firstObject];
        [_subHeaderView.showAllButton addTarget:self action:@selector(showAllBoutiqueLit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subHeaderView;
}

- (void)showAllBoutiqueLit:(id)sender
{
    BoutiqueListViewController *controller = [BoutiqueListViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (XFBannerView*)xfBanner
{
    if (!_xfBanner) {
        __weak typeof (self) weakSelf = self;
        _xfBanner = [XFBannerView initBannerViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 235) imageLinkURL:@[@""] subtitleArray:nil placeHoderImageName:@"pic_banner_load" bannerTapped:^(NSInteger index) {
            if (weakSelf.banners.count > index) {
                BannerItem *banner = [weakSelf.banners objectAtIndex:index];
                FeedDetailViewController *controller = [FeedDetailViewController new];
                controller.ColumnId = banner.ColumnId;
                controller.Id = banner.Id;
                controller.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:controller animated:YES];
            }
        }];
    }
    return _xfBanner;
}

#pragma rewrite tableview to customize
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        __weak typeof (self) weakSelf = self;
        if ((self.bannerOption & XFMainBanner) &&
            (self.bannerOption & XFSubBanner)) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250.0f + 151.0f)];
            [view addSubview:self.xfBanner];
            [view addSubview:self.subHeaderView];
            __weak typeof (view) weakView = view;
            [self.xfBanner mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakView.mas_top);
                make.left.equalTo(weakView.mas_left);
                make.right.equalTo(weakView.mas_right);
                make.height.mas_equalTo(235.0f);
            }];
            
            [self.subHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.xfBanner.mas_bottom).offset(15.0f);
                make.left.equalTo(weakView.mas_left);
                make.right.equalTo(weakView.mas_right);
                make.height.mas_equalTo(151.0f);
            }];
            self.tableView.tableHeaderView = view;
        }else{
            self.tableView.tableHeaderView = self.xfBanner;
        }
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

@end
