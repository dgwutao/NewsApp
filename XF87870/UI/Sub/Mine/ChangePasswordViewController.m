//
//  ChangePasswordViewController.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    self.borderView.layer.cornerRadius = 3.0f;
    self.borderView.layer.masksToBounds = YES;
    self.borderView.layer.borderWidth = 1.0f;
    self.borderView.layer.borderColor = [[UIColor colorWithHexValue:0xD7D7D7 alpha:1]CGColor];
    self.confirmButton.layer.cornerRadius = 3.0f;
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.enabled = NO;
    [self.oldPwdTextField addTarget:self
                            action:@selector(textFieldDidChanged:)
                  forControlEvents:UIControlEventEditingChanged];
    [self.reNewPwdTextField addTarget:self
                          action:@selector(textFieldDidChanged:)
                forControlEvents:UIControlEventEditingChanged];
    [self.firstNewPwdTextField addTarget:self
                                 action:@selector(textFieldDidChanged:)
                       forControlEvents:UIControlEventEditingChanged];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.oldPwdTextField resignFirstResponder];
    [self.reNewPwdTextField resignFirstResponder];
    [self.firstNewPwdTextField resignFirstResponder];
}

- (void)textFieldDidChanged:(id)sender
{
    if (self.oldPwdTextField.text.length > 0 &&
        self.firstNewPwdTextField.text.length > 0 &&
        self.reNewPwdTextField.text.length > 0 &&
        [self.firstNewPwdTextField.text isEqualToString:self.reNewPwdTextField.text]) {
        [self.confirmButton setBackgroundColor:[UIColor colorWithHexValue:0x3498ff alpha:1.0]];
        self.confirmButton.enabled = YES;
    }else{
        [self.confirmButton setBackgroundColor:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0]];
        self.confirmButton.enabled = NO;
    }
}

@end
