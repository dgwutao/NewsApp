//
//  PhotoLibraryViewController.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "PhotoLibraryViewController.h"
#import "PhotoLibraryTableViewCell.h"
#import "PhotoGroupViewController.h"
#import "AssetGoupItem.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoLibraryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@end

static NSString* tableViewCellRegister = @"PhotoLibraryTableViewCell";
static NSString* tableViewIdentifier = @"PhotoLibraryTableViewCellIdentifier";

@implementation PhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的相册";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    self.dataSource = [NSMutableArray new];
    [self.view addSubview:self.tableView];
    ALAuthorizationStatus auth = [ALAssetsLibrary authorizationStatus];
    if (auth == ALAuthorizationStatusRestricted ||
        auth == ALAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"相册" message:@"用户禁止访问相册！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        @autoreleasepool {
            __weak typeof (self) weakSelf = self;
            [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if (group) {
                    [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                    AssetGoupItem *groupItem = [AssetGoupItem new];
                    groupItem.groupName = [group valueForProperty:ALAssetsGroupPropertyName];
                    groupItem.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
                    groupItem.assetsCount = [group numberOfAssets];
                    groupItem.group = group;
                    [weakSelf.dataSource addObject:groupItem];
                }else{
                    [weakSelf.tableView reloadData];
                }
            } failureBlock:^(NSError *error) {
                NSLog(@"error:%@",error);
            }];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > indexPath.row) {
        AssetGoupItem *groupItem = [self.dataSource objectAtIndex:indexPath.row];
        PhotoLibraryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableViewIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.libraryLabel.text = [NSString stringWithFormat:@"%@（%zi）", groupItem.groupName,groupItem.assetsCount];
        [cell.coverImageView setImage:groupItem.thumbImage];
        return cell;
    }
    return [UITableViewCell new];
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:tableViewCellRegister bundle:nil] forCellReuseIdentifier:tableViewIdentifier];
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
    AssetGoupItem *assetGroup = [self.dataSource objectAtIndex:indexPath.row];
    PhotoGroupViewController *controller = [PhotoGroupViewController new];
    controller.assetGroup = assetGroup;
    controller.title = assetGroup.groupName;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (ALAssetsLibrary*)assetsLibrary
{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

@end
