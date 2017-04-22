//
//  MyComplainViewController.m
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MyComplainViewController.h"

@interface MyComplainViewController ()<UITextFieldDelegate>

@end

@implementation MyComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的吐槽";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [super setRightNavItemWithTitle:@"提交"];
    self.textBorder.layer.borderWidth = 1.0f;
    self.textBorder.layer.borderColor = [UIColor colorWithHexValue:0xf3f3f3 alpha:1.0f].CGColor;
    self.phoneBorder.layer.borderWidth = 1.0f;
    self.phoneBorder.layer.borderColor = [UIColor colorWithHexValue:0xf3f3f3 alpha:1.0f].CGColor;
    self.phoneTextField.delegate = self;
}

- (void)rightItemAction
{
    if (self.suggestionTextView.text.length == 0) {
        [XFToastView showTextToast:@"请输入反馈内容！"];
        return;
    }
    NSDictionary *params = @{@"name":self.phoneTextField.text,
                             @"content":self.suggestionTextView.text,
                             @"username":@"蓝柏林",
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:AddFeedback
     params:params parser:[XFHttpResponseParser sharedParser].CollectionInfoParser progress:nil
     success:^(id response) {
         [XFToastView showTextToast:@"吐槽成功！"];
     } failure:^(NSError *error) {
         
     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.suggestionTextView resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, -30, SCREEN_WIDTH, SCREEN_HEIGHT);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

@end
