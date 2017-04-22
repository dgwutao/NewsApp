//
//  BindPhoneViewController_3.m
//  XF87870
//
//  Created by xf on 2016/12/5.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BindPhoneViewController_3.h"

@interface BindPhoneViewController_3 ()<UITextFieldDelegate>
{
    NSTimer *_timer;
    NSInteger _countdown;
}

@end

@implementation BindPhoneViewController_3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    self.borderView.layer.cornerRadius = 3.0f;
    self.borderView.layer.masksToBounds = YES;
    self.borderView.layer.borderWidth = 1.0f;
    self.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]CGColor];
    self.confirmButton.layer.cornerRadius = 3.0f;
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.enabled = NO;
    [self.phoneTextField addTarget:self
                       action:@selector(textFieldDidChanged:)
             forControlEvents:UIControlEventEditingChanged];
    
    [self.codeTextField addTarget:self
                            action:@selector(textFieldDidChanged:)
                  forControlEvents:UIControlEventEditingChanged];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.codeTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)textFieldDidChanged:(id)sender
{
    if ([self.phoneTextField.text isPhoneNumber] && self.codeTextField.text.length > 0){
        [self.confirmButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
        self.confirmButton.enabled = YES;
    }else{
        [self.confirmButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
        self.confirmButton.enabled = NO;
    }
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.codeTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)timerCountdown
{
    _countdown--;
    if (_countdown <= 0) {
        [_timer invalidate];
        _timer = nil;
        _countdown = 60;
        self.codeButton.enabled = YES;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [self.codeButton setTitle:[NSString stringWithFormat:@"%zi秒",_countdown] forState:UIControlStateNormal];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (IBAction)codeButtonTapped:(id)sender
{
    self.codeButton.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown) userInfo:nil repeats:YES];
}

- (IBAction)confirmButtonTapped:(id)sender
{
    
}

@end
