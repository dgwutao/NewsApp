//
//  ChangeNameViewController.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()<UITextFieldDelegate>

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户昵称";
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [super setRightNavItemWithTitle:@"保存"];
    self.textField.delegate = self;
    [self.textField addTarget:self
                       action:@selector(textFieldDidChanged:)
             forControlEvents:UIControlEventEditingChanged];
}

- (void) rightItemAction
{
    
}

- (void)textFieldDidChanged:(id)sender
{
    if (self.textField.text.length > 0) {
        self.cancelButton.hidden = NO;
    }else{
        self.cancelButton.hidden = YES;
    }
}

- (IBAction)cancelButtonTapped:(id)sender
{
    self.textField.text = @"";
    self.cancelButton.hidden = YES;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end
