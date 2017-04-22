//
//  ProfileViewController.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ProfileViewController.h"
#import "ChangeAvatarView.h"
#import "PhotoLibraryViewController.h"
#import "CameraViewController.h"
#import "ChangeNameViewController.h"
#import "ChangePasswordViewController.h"
#import "BindPhoneViewController.h"
#import "BindPhoneViewController_3.h"
#import "PhotoLibraryViewController.h"

@interface ProfileViewController ()
{
    ChangeAvatarView *_changeAvatarView;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    self.avatarView.layer.cornerRadius = 27.0f;
    self.avatarView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *avatarViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarViewTapped)];
    [self.avatarView addGestureRecognizer:avatarViewTapped];
    
    UITapGestureRecognizer *nameViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nameViewTapped)];
    [self.nameView addGestureRecognizer:nameViewTapped];
    
    UITapGestureRecognizer *phoneViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneViewTapped)];
    [self.phoneView addGestureRecognizer:phoneViewTapped];
    
    UITapGestureRecognizer *changePwdViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePwdViewTapped)];
    [self.changePwdView addGestureRecognizer:changePwdViewTapped];
}

- (void) avatarViewTapped
{
    _changeAvatarView = [[[NSBundle mainBundle]loadNibNamed:@"ChangeAvatarView" owner:self options:nil] firstObject];
    
    UITapGestureRecognizer *backgroundTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped)];
    [_changeAvatarView.backgroundView addGestureRecognizer:backgroundTapped];
    
    UITapGestureRecognizer *photoTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTapped)];
    [_changeAvatarView.photoLibraryView addGestureRecognizer:photoTapped];
    
    UITapGestureRecognizer *cameraTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cameraTapped)];
    [_changeAvatarView.cameraView addGestureRecognizer:cameraTapped];
    
    [_changeAvatarView showInWindow];
}

- (void) backgroundTapped
{
    [_changeAvatarView hideView];
    _changeAvatarView = nil;
}

- (void) photoTapped
{
    [_changeAvatarView hideView];
    _changeAvatarView = nil;
    PhotoLibraryViewController *controller = [PhotoLibraryViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) cameraTapped
{
    [_changeAvatarView hideView];
    _changeAvatarView = nil;
    CameraViewController *controller = [[CameraViewController alloc]initWithNibName:@"CameraViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) nameViewTapped
{
    ChangeNameViewController *controller = [[ChangeNameViewController alloc]initWithNibName:@"ChangeNameViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) phoneViewTapped
{
    BindPhoneViewController *controller = [[BindPhoneViewController alloc]initWithNibName:@"BindPhoneViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) changePwdViewTapped
{
    ChangePasswordViewController *controller = [[ChangePasswordViewController alloc]initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
