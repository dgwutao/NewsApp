//
//  ChangePasswordViewController.h
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"

@interface ChangePasswordViewController : XFBaseViewController
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNewPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *reNewPwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end
