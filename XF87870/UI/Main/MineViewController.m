//
//  MineViewController.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "MySettingViewController.h"
#import "MyComplainViewController.h"
#import "CollectionViewController.h"
#import "SubscriptionViewController.h"
#import "MyFootprintViewController.h"
#import "MyCommentViewController.h"
#import "ProfileViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(footprintTapped)];
    [self.footprintView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(complainTapped)];
    [self.complainView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentTapped)];
    [self.myCommentView addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingsTapped)];
    [self.settingsView addGestureRecognizer:tap4];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logoutTapped)];
    [self.logoutView addGestureRecognizer:tap5];
}

- (void) footprintTapped
{
    MyFootprintViewController *controller = [MyFootprintViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) complainTapped
{
    MyComplainViewController *controller = [[MyComplainViewController alloc]initWithNibName:@"MyComplainViewController" bundle:nil];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) commentTapped
{
    MyCommentViewController *controller = [MyCommentViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) settingsTapped
{
    MySettingViewController *controller = [MySettingViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) logoutTapped
{
    
}

- (IBAction)avatarButtonTapped:(id)sender
{
//    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//    login.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:login animated:YES];
        ProfileViewController *login = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)mySubscriptionTapped:(id)sender
{
    SubscriptionViewController *controller = [SubscriptionViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)myCollectionButtonTapped:(id)sender
{
    CollectionViewController *controller = [CollectionViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
