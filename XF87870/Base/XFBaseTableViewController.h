//
//  XFBaseTableViewController.h
//  XF87870
//
//  Created by xf on 2016/11/10.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"
typedef NS_ENUM(NSUInteger, BannerOptions) {
    XFMainBanner = 1 << 0,
    XFSubBanner = 1 << 1
};

typedef NS_ENUM(NSUInteger, PullRefreshOptions) {
    XFPullRefreshOptionNone = 1 << 0,
    XFPullRefreshOptionPullDown = 1 << 1,
    XFPullRefreshOptionPullUp = 1 << 2
};

@interface XFBaseTableViewController : XFBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger pageIndex;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (copy, nonatomic) id tableViewCellRegister;
@property (copy, nonatomic) NSString *tableViewIdentifier;
@property (copy, nonatomic) NSArray *subBanners;
@property (copy, nonatomic) NSArray *banners;
@property (assign, nonatomic) BOOL navbarTranslucent;
@property (assign, nonatomic) BannerOptions bannerOption;
@property (assign, nonatomic) PullRefreshOptions PullRefreshOptions;

-(void) loadBannerWithCid:(NSString*)cid;
-(void) loadSubBannerWithUrl:(NSString*)url andTitle:(NSString*)title;

- (void)pullDownRefresh:(void(^)(void)) completion;
- (void)pullUpRefresh:(void(^)(void)) completion;
@end
