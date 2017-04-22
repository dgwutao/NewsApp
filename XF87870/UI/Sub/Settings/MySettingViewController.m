//
//  MySettingViewController.m
//  XF87870
//
//  Created by xf on 2016/11/18.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MySettingViewController.h"
#import "MySettingsTableViewCell.h"
#import "ContactUsViewController.h"
#import "AboutUsViewController.h"

@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_settings;
}
@property (strong, nonatomic) UITableView *tableView;
@end

static NSString *mySettingsTableViewCellIdentifier = @"MySettingsTableViewCellIdentifier";

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的设置";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    _settings = @[@"联系我们",@"关于我们",@"版本检测"];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [_settings objectAtIndex:indexPath.row];
    MySettingsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:mySettingsTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.titleLabel.text = title;
    return cell;
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"MySettingsTableViewCell" bundle:nil] forCellReuseIdentifier:mySettingsTableViewCellIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
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
    switch (indexPath.row) {
        case 0:
        {
            ContactUsViewController *controller = [[ContactUsViewController alloc]initWithNibName:@"ContactUsViewController" bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 1:
        {
            AboutUsViewController *controller = [[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 2:
        {
            
            break;
        }
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _settings.count;
}
@end
