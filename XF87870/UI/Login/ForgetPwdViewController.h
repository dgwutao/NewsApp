//
//  ForgetPwdViewController.h
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLoginViewController.h"
#import "XFLoginKit.h"

@interface ForgetPwdViewController : BaseLoginViewController
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *VerifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *GetVerifyCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *CheckButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;
@property (weak, nonatomic) IBOutlet UIButton *GetPwdButton;

@end
