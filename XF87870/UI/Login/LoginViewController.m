//
//  LoginViewController.m
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPwdViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
{
    bool _pwdShown;
}
@end

@implementation LoginViewController

- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_login_ic_delete"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(0, 0, 60, 30);
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [rightButton addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.borderView.layer.cornerRadius = 3.0f;
    self.borderView.layer.masksToBounds = YES;
    self.borderView.layer.borderWidth = 1.0f;
    self.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]   CGColor];
    self.loginButton.layer.cornerRadius = 3.0f;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.enabled = NO;
    [self.usernameTextField addTarget:self
                               action:@selector(textFieldDidChanged:)
                     forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self
                               action:@selector(textFieldDidChanged:)
                     forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChanged:(id)sender
{
    if (sender == self.usernameTextField) {
        if (self.usernameTextField.text.length > 0) {
            [self.deleteButton setHidden:NO];
        }else{
            [self.deleteButton setHidden:YES];
        }
    }else{
        if (self.passwordTextField.text.length > 0) {
            [self.visibleButton setHidden:NO];
        }else{
            [self.visibleButton setHidden:YES];
            if (_pwdShown) {
                _pwdShown = NO;
                [self.visibleButton setImage:[UIImage imageNamed:@"btn_login_ic_invisible"] forState:UIControlStateNormal];
            }
        }
    }
    if (self.usernameTextField.text.length >0 && self.passwordTextField.text.length > 0) {
        [self.loginButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
        self.loginButton.enabled = YES;
    }else{
        [self.loginButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
        self.loginButton.enabled = NO;
    }
}

- (void) hideKeyboard
{
    if (self.keyboardShown) {
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
}

- (IBAction)loginButtonTapped:(id)sender
{
    
}

- (IBAction)forgetPwdButtonTapped:(id)sender
{
    ForgetPwdViewController *forget = [[ForgetPwdViewController alloc]initWithNibName:@"ForgetPwdViewController" bundle:nil];
    [self.navigationController pushViewController:forget animated:YES];
}

- (IBAction)deleteButtonTapped:(id)sender
{
    self.usernameTextField.text = @"";
    [self textFieldDidChanged:self.usernameTextField];
}

- (IBAction)visibleButtonTapped:(id)sender
{
    if (!_pwdShown) {
        _pwdShown = YES;
        [self.visibleButton setImage:[UIImage imageNamed:@"btn_login_ic_visible"] forState:UIControlStateNormal];
        [self.passwordTextField setSecureTextEntry:NO];
    }else{
        _pwdShown = NO;
        [self.passwordTextField setSecureTextEntry:YES];
        [self.visibleButton setImage:[UIImage imageNamed:@"btn_login_ic_invisible"] forState:UIControlStateNormal];
    }
}

- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemAction{
    RegisterViewController *registerView = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:YES];
}

@end
