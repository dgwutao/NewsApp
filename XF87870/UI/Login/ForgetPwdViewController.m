//
//  ForgetPwdViewController.m
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()
{
    NSTimer *_timer;
    NSInteger _countdown;
}
@end

@implementation ForgetPwdViewController

- (void)loadView{
    [super loadView];
    _countdown = 60;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.borderView.layer.cornerRadius = 3.0f;
    self.borderView.layer.masksToBounds = YES;
    self.borderView.layer.borderWidth = 1.0f;
    self.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]CGColor];
    self.GetPwdButton.layer.cornerRadius = 3.0f;
    self.GetPwdButton.layer.masksToBounds = YES;
    [self.phoneTextField addTarget:self
                               action:@selector(textFieldDidChanged:)
                     forControlEvents:UIControlEventEditingChanged];
    [self.PwdTextField addTarget:self
                            action:@selector(textFieldDidChanged:)
                  forControlEvents:UIControlEventEditingChanged];
    [self.VerifyCodeTextField addTarget:self
                            action:@selector(textFieldDidChanged:)
                  forControlEvents:UIControlEventEditingChanged];
}

- (void)timerCountdown
{
    _countdown--;
    if (_countdown <= 0) {
        [_timer invalidate];
        _timer = nil;
        _countdown = 60;
        self.GetVerifyCodeButton.enabled = YES;
        [self.GetVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [self.GetVerifyCodeButton setTitle:[NSString stringWithFormat:@"%zi秒",_countdown] forState:UIControlStateNormal];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)textFieldDidChanged:(id)sender
{
    if (self.VerifyCodeTextField.text.length > 0 && [[XFLoginKit sharedLoginKit] isPhoneNumber:self.phoneTextField.text] && self.PwdTextField.text.length > 5) {
        [self.GetPwdButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
    }else{
        [self.GetPwdButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
    }
}

- (void) hideKeyboard
{
    if (self.keyboardShown) {
        [self.phoneTextField resignFirstResponder];
        [self.PwdTextField resignFirstResponder];
        [self.VerifyCodeTextField resignFirstResponder];
    }
}

- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getPwdButtonTapped:(id)sender
{
    
}

- (IBAction)checkButtonTapped:(id)sender
{
    
}

- (IBAction)protocolButtonTapped:(id)sender
{
    
}

- (IBAction)getVerifyCodeButtonTapped:(id)sender
{
    self.GetVerifyCodeButton.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown) userInfo:nil repeats:YES];
}

@end
