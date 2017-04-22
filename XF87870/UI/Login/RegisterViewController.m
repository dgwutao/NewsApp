//
//  RegisterViewController.m
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "RegisterViewController.h"
#import "PhoneRegisterView.h"
#import "AccountRegisterView.h"
#import "RegisterTitleView.h"
#import "XFLoginKit.h"

@interface RegisterViewController ()<UIScrollViewDelegate>
{
    PhoneRegisterView *_phoneRegisterView;
    AccountRegisterView *_accountRegsiterView;
    RegisterTitleView *_registerTitleView;
    UIScrollView *_scrollView;
    NSTimer *_timer;
    NSInteger _countdown;
}

@end

@implementation RegisterViewController

- (void)loadView{
    [super loadView];
    _countdown = 60;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
    [self.view addSubview:_scrollView];
    _phoneRegisterView = [[[NSBundle mainBundle] loadNibNamed:@"PhoneRegisterView" owner:self options:nil] firstObject];
    _registerTitleView = [[[NSBundle mainBundle] loadNibNamed:@"RegisterTitleView" owner:self options:nil] firstObject];
    _registerTitleView.frame = CGRectMake(0, 0, 180, 40);
    [_registerTitleView.phoneButton addTarget:self action:@selector(slideAction:) forControlEvents:UIControlEventTouchUpInside];
    [_registerTitleView.accountButton addTarget:self action:@selector(slideAction:) forControlEvents:UIControlEventTouchUpInside];
    [_registerTitleView.accountButton setTitleColor:[UIColor colorWithHexValue:0x8c8c8c alpha:0.5] forState:UIControlStateNormal];
    self.navigationItem.titleView = _registerTitleView;
    _accountRegsiterView = [[[NSBundle mainBundle] loadNibNamed:@"AccountRegisterView" owner:self options:nil] firstObject];
    _phoneRegisterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _accountRegsiterView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _phoneRegisterView.borderView.layer.cornerRadius = 3.0f;
    _phoneRegisterView.borderView.layer.masksToBounds = YES;
    _phoneRegisterView.borderView.layer.borderWidth = 1.0f;
    _phoneRegisterView.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]CGColor];
    _phoneRegisterView.registerButton.layer.cornerRadius = 3.0f;
    _phoneRegisterView.registerButton.layer.masksToBounds = YES;
    [_phoneRegisterView.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneRegisterView.getVerifyCodeButton addTarget:self action:@selector(getVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    _phoneRegisterView.registerButton.enabled = NO;
    _accountRegsiterView.borderView.layer.cornerRadius = 3.0f;
    _accountRegsiterView.borderView.layer.masksToBounds = YES;
    _accountRegsiterView.borderView.layer.borderWidth = 1.0f;
    _accountRegsiterView.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]CGColor];
    _accountRegsiterView.registerButton.layer.cornerRadius = 3.0f;
    _accountRegsiterView.registerButton.layer.masksToBounds = YES;
    [_accountRegsiterView.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    _accountRegsiterView.registerButton.enabled = NO;
    [_scrollView addSubview:_phoneRegisterView];
    [_scrollView addSubview:_accountRegsiterView];
    
    [_accountRegsiterView.pwdTextField addTarget:self
                               action:@selector(textFieldDidChanged:)
                     forControlEvents:UIControlEventEditingChanged];
    [_accountRegsiterView.usernameTextField addTarget:self
                                          action:@selector(textFieldDidChanged:)
                                forControlEvents:UIControlEventEditingChanged];
    [_accountRegsiterView.verifyCodeTextField addTarget:self
                                          action:@selector(textFieldDidChanged:)
                                forControlEvents:UIControlEventEditingChanged];
    
    [_phoneRegisterView.verifyCodeTextField addTarget:self
                                          action:@selector(textFieldDidChanged:)
                                forControlEvents:UIControlEventEditingChanged];
    [_phoneRegisterView.phoneTextField addTarget:self
                                          action:@selector(textFieldDidChanged:)
                                forControlEvents:UIControlEventEditingChanged];
    [_phoneRegisterView.pwdTextField addTarget:self
                                          action:@selector(textFieldDidChanged:)
                                forControlEvents:UIControlEventEditingChanged];
}

- (void)getVerifyCodeAction:(id)sender
{
    _phoneRegisterView.getVerifyCodeButton.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown) userInfo:nil repeats:YES];
}

- (void)timerCountdown
{
    _countdown--;
    if (_countdown <= 0) {
        [_timer invalidate];
        _timer = nil;
        _countdown = 60;
        _phoneRegisterView.getVerifyCodeButton.enabled = YES;
        [_phoneRegisterView.getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [_phoneRegisterView.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%zi秒",_countdown] forState:UIControlStateNormal];
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
    if (_scrollView.contentOffset.x == 0){
        if (_phoneRegisterView.verifyCodeTextField.text.length > 0 &&
            [[XFLoginKit sharedLoginKit] isPhoneNumber:_phoneRegisterView.phoneTextField.text] &&
            _phoneRegisterView.pwdTextField.text.length > 5) {
            [_phoneRegisterView.registerButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
            _phoneRegisterView.registerButton.enabled = YES;
        }else{
            [_phoneRegisterView.registerButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
            _phoneRegisterView.registerButton.enabled = NO;
        }
    }else{
        if (_accountRegsiterView.verifyCodeTextField.text.length > 0 &&
            _accountRegsiterView.usernameTextField.text.length > 0 &&
            _accountRegsiterView.pwdTextField.text.length > 5) {
            [_accountRegsiterView.registerButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
            _accountRegsiterView.registerButton.enabled = YES;
        }else{
            [_accountRegsiterView.registerButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
            _accountRegsiterView.registerButton.enabled = NO;
        }
    }
}

- (void) hideKeyboard
{
    if (self.keyboardShown) {
        [_phoneRegisterView.pwdTextField resignFirstResponder];
        [_phoneRegisterView.phoneTextField resignFirstResponder];
        [_phoneRegisterView.verifyCodeTextField resignFirstResponder];
        [_accountRegsiterView.pwdTextField resignFirstResponder];
        [_accountRegsiterView.usernameTextField resignFirstResponder];
        [_accountRegsiterView.verifyCodeTextField resignFirstResponder];
    }
}

- (void)registerAction:(id)sender
{
    if (sender == _phoneRegisterView.registerButton) {
        
    }else{
        
    }
}

- (void)slideAction:(id)sender
{
    if (sender == _registerTitleView.accountButton) {
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        [_registerTitleView.phoneButton setTitleColor:[UIColor colorWithHexValue:0x8c8c8c alpha:0.5] forState:UIControlStateNormal];
        [_registerTitleView.accountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [_registerTitleView.phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerTitleView.accountButton setTitleColor:[UIColor colorWithHexValue:0x8c8c8c alpha:0.5] forState:UIControlStateNormal];
    }
    [self hideKeyboard];
}

- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x == 0){
        [_registerTitleView.phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerTitleView.accountButton setTitleColor:[UIColor colorWithHexValue:0xd7d7d7 alpha:0.5] forState:UIControlStateNormal];
    }else{
        [_registerTitleView.phoneButton setTitleColor:[UIColor colorWithHexValue:0xd7d7d7 alpha:0.5] forState:UIControlStateNormal];
        [_registerTitleView.accountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

@end
