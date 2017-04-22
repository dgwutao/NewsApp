//
//  BindPhoneViewController_2.m
//  XF87870
//
//  Created by xf on 2016/12/5.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BindPhoneViewController_2.h"
#import "BindPhoneViewController_3.h"

@interface BindPhoneViewController_2 ()
{
    NSTimer *_timer;
    NSInteger _countdown;
}
@end

@implementation BindPhoneViewController_2

- (void)loadView{
    [super loadView];
    _countdown = 60;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    self.borderView.layer.cornerRadius = 3.0f;
    self.borderView.layer.masksToBounds = YES;
    self.borderView.layer.borderWidth = 1.0f;
    self.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]CGColor];
    self.nextButton.layer.cornerRadius = 3.0f;
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.enabled = NO;
    [self.textField addTarget:self
                             action:@selector(textFieldDidChanged:)
                   forControlEvents:UIControlEventEditingChanged];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown) userInfo:nil repeats:YES];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

- (void)textFieldDidChanged:(id)sender
{
    if (self.textField.text.length > 0){
        [self.nextButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
        self.nextButton.enabled = YES;
    }else{
        [self.nextButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
        self.nextButton.enabled = NO;
    }
}

- (void)timerCountdown
{
    _countdown--;
    if (_countdown <= 0) {
        [_timer invalidate];
        _timer = nil;
        _countdown = 60;
        [self.countdownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [self.countdownButton setTitle:[NSString stringWithFormat:@"%zi秒",_countdown] forState:UIControlStateNormal];
    }
}
- (IBAction)nextButtonTapped:(id)sender
{
    BindPhoneViewController_3 *controller = [[BindPhoneViewController_3 alloc]initWithNibName:@"BindPhoneViewController_3" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        [self.countdownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

@end
