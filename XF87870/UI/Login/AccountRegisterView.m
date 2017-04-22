//
//  AccountRegisterView.m
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "AccountRegisterView.h"

@implementation AccountRegisterView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.pwdTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
}

@end
