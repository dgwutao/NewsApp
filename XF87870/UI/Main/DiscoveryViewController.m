//
//  DiscoveryViewController.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "XFHttpResponseParser.h"
#import "FindListItem.h"
#import "DiscoveryTableViewCell.h"
#import "FeedDetailViewController.h"
#import "ShareView.h"
#import "KRVideoPlayerController.h"
#import "CommentsViewController.h"
#import "SearchViewController.h"

@interface DiscoveryViewController ()<FindTableViewCellProtocol,MWPhotoBrowserDelegate>
{
    NSArray *_imageUrls;
}
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@end

@implementation DiscoveryViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"DiscoveryTableViewCell";
    self.tableViewIdentifier = @"DiscoveryTableViewCellIdentifier";
    self.navbarTranslucent = YES;
    self.bannerOption = XFMainBanner | XFSubBanner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setRightNavItemWithImage:@"ic_nav_search"];
    [self.tableView.mj_header beginRefreshing];
}

-(void) rightItemAction{
    SearchViewController *controller = [SearchViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pullDownRefresh:(void(^)(void)) completion
{
    self.pageIndex = 1;
    [self loadBannerWithCid:@"1"];
    [self loadSubBannerWithUrl:BoutiquecaInfo andTitle:@"精品栏目"];
    [self loadData:completion];
}

- (void)pullUpRefresh:(void(^)(void)) completion
{
    self.pageIndex++;
    [self loadData:completion];
}

- (void) loadData:(void(^)(void)) completion
{
//    columnid:1新闻 2视频 3评测 6游戏 如1的时候imageurllist将会有返回值 2的时候 videoinfo有返回值 非3的时候gamegrade为0
    NSDictionary *params = @{@"pagesize":[NSString stringWithFormat:@"%zi",self.pageSize],
                             @"pageindex":[NSString stringWithFormat:@"%zi",self.pageIndex],
                             @"uid":DefaultUid};
    __weak typeof (self) weakSelf = self;
    [self.sessionManager
     sendGetHttpRequestWithUrl:FindInfo params:params
     parser:[XFHttpResponseParser sharedParser].FindInfoParser progress:nil
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        FindListItem *item = [self.dataSource objectAtIndex:indexPath.row];
        DiscoveryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setData:item];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        FindListItem *item = [self.dataSource objectAtIndex:indexPath.row];
        if (!item.cellHeight) {
            NSMutableDictionary *attribute1 = [[NSMutableDictionary alloc] init];
            [attribute1 setObject:[UIFont systemFontOfSize:17.0f] forKey:NSFontAttributeName];
            CGSize size1 = [item.Name sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 30.0f, FLT_MAX) Attributes:attribute1];
            NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
            [attribute setObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName];
            CGSize size = [item.Description sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 30.0f, FLT_MAX) Attributes:attribute];
            CGFloat imageHeight = 0;
            if ([item.ColumnId isEqualToString:@"1_0"]) {
                if (item.ImageUrlList.count == 1) {
                    imageHeight = 164.0f;
                }else if(item.ImageUrlList.count > 1){
                    if (item.ImageUrlList.count % 3 == 0) {
                        imageHeight = (item.ImageUrlList.count / 3) * 106 +  (item.ImageUrlList.count / 3 - 1) * 6;
                    }else{
                        imageHeight = (item.ImageUrlList.count / 3 + 1) * 106 +  (item.ImageUrlList.count / 3) * 6;
                    }
                }
            }else{
                if (item.ImageUrlList.count > 0 || item.VideoImageUrl.length > 0) {
                    imageHeight = 186.0f;
                }
            }
            item.cellHeight = size.height + size1.height + 132.0f + imageHeight;
        }
        return item.cellHeight;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (MWPhotoBrowser *)photoBrowser {
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = NO;
        _photoBrowser.isHideNav = YES;
        _photoBrowser.zoomPhotosToFill = YES;
    }
    return _photoBrowser;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _imageUrls.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (_imageUrls.count > index){
        NSString *url = [_imageUrls objectAtIndex:index];
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        return photo;
    }
    return nil;
}

#pragma FindTableViewCellProtocol
- (void) imageViewTapped:(FindListItem*)item index:(NSInteger)index
{
    _imageUrls = item.ImageUrlList;
    [self.photoBrowser reloadData];
    [self.photoBrowser setCurrentPhotoIndex:index];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
    navigation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void) playVideo:(FindListItem*)item
{
    if (item.VideoUrl && item.VideoUrl.length > 0) {
        KRVideoPlayerController *videoViewController = [[KRVideoPlayerController alloc]init];
        videoViewController.videoUrl = [NSURL URLWithString:item.VideoUrl];
        [self.navigationController presentViewController:videoViewController animated:YES completion:nil];
    }
}

- (void) gotoDetailViewControler:(FindListItem*)item
{
    FeedDetailViewController *controller = [FeedDetailViewController new];
    controller.ColumnId = item.ColumnId;
    controller.Id = item.Id;
    controller.Cid = [XFUtil getCidWithColumnId:item.ColumnId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)likeFindItem:(FindListItem*)item success:(void(^)())success
{
    [[XFCommonFunc sharedInstance]
     infoLikeWithCid:[XFUtil getCidWithColumnId:item.ColumnId] infoId:item.Id
     success:^{
         if (success) {
             success();
         }
    }failure:^(NSError *error){
        [XFToastView showTextToast:@"点赞失败！"];
    }];
}

- (void)collectFindItem:(FindListItem*)item success:(void(^)(BOOL))success
{
    if ([item.IsFavorite isEqualToString:@"1"]) {
        [[XFCommonFunc sharedInstance]
         deleteFavoriteInfoWithInfoId:item.Id
         success:^{
             if (success) {
                 success(NO);
             }
         } failure:^(NSError *error){
             
         }];
    }else{
        [[XFCommonFunc sharedInstance]
         addFavoriteInfoWithCid:[XFUtil getCidWithColumnId:item.ColumnId] infoId:item.Id
         success:^{
             if (success) {
                 success(YES);
             }
         } failure:^(NSError *error){
             
         }];
    }
}

- (void)shareFindItem:(FindListItem*)item
{
    ShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] firstObject];
    shareView.cid = [XFUtil getCidWithColumnId:item.ColumnId];
    shareView.infoId = item.Id;
    shareView.webPageUrl = item.ShareUrl;
    shareView.feedName = item.Name;
    shareView.feedDescription = item.Description;
    shareView.shareImageUrl = item.shareImageUrl;
    [shareView showWithOptions:XFWeChatFriend|XFWeChatMoments|XFQQ|XFQZone|XFWeibo];
}

- (void) showAllComment:(FindListItem*)item
{
    if ([item.Comment isEqualToString:@"0"]) {
        [XFToastView showTextToast:@"没有评论！"];
        return;
    }
    CommentsViewController *controller = [CommentsViewController new];
    controller.Id = item.Id;
    controller.ColumnId = item.ColumnId;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) jumpToTop
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

@end
