//
//  BindPhoneViewController.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "BindPhoneViewController_2.h"

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    self.rebindButton.layer.cornerRadius = 3.0f;
    self.rebindButton.layer.masksToBounds = YES;
}

- (IBAction)rebindButtonTapped:(id)sender
{
    BindPhoneViewController_2 *controller = [[BindPhoneViewController_2 alloc]initWithNibName:@"BindPhoneViewController_2" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
