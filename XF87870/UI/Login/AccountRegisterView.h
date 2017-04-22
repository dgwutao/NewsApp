//
//  AccountRegisterView.h
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountRegisterView : UIView
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIImageView *verifyCodeImageView;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;


@end
