//
//  MyFootprintViewController.m
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MyFootprintViewController.h"

@interface MyFootprintViewController ()

@end

@implementation MyFootprintViewController

- (void)loadView{
    [super loadView];
    self.tableViewCellRegister = @"BoutiqueListTableViewCell";
    self.tableViewIdentifier = @"BoutiqueListTableViewCellIdentifier";
    self.navbarTranslucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的足迹";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
}

- (UITableView*) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:self.tableViewCellRegister bundle:nil] forCellReuseIdentifier:self.tableViewIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (self.dataSource.count > indexPath.row) {
    //        BoutiqueInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
    //        BoutiqueTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:self.tableViewIdentifier forIndexPath:indexPath];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",item.ImgUrl,item.Img]] placeholderImage:[UIImage imageNamed:@"pic_banner_load"]];
    //        cell.titleLabel.text = item.Name;
    //        cell.contentLabel.text = item.Description;
    //        cell.dateLabel.text = item.CreateDate;
    //        cell.index = indexPath.row;
    //        cell.delegate = self;
    //        return cell;
    //    }else{
    return [UITableViewCell new];
    //    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (self.dataSource.count > indexPath.row) {
    //        BoutiqueInfoItem *item = [self.dataSource objectAtIndex:indexPath.row];
    //        if (!item.cellHeight) {
    //            NSMutableDictionary *attribute1 = [[NSMutableDictionary alloc] init];
    //            [attribute1 setObject:[UIFont systemFontOfSize:17.0f] forKey:NSFontAttributeName];
    //            CGSize size1 = [item.Name sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 30.0f, FLT_MAX) Attributes:attribute1];
    //
    //            NSMutableDictionary *attribute2 = [[NSMutableDictionary alloc] init];
    //            [attribute2 setObject:[UIFont systemFontOfSize:14.0f] forKey:NSFontAttributeName];
    //            CGSize size2 = [item.Description sizeWithAttributes:CGSizeMake(SCREEN_WIDTH - 30.0f, FLT_MAX) Attributes:attribute2];
    //
    //            item.cellHeight = size1.height + size2.height + 280.0f;
    //        }
    //        return item.cellHeight;
    //    }else{
    return 0;
    //    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
@end
