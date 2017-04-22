//
//  BaseLoginViewController.h
//  XF87870
//
//  Created by xf on 2016/11/15.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLoginViewController : UIViewController<UITextFieldDelegate>
@property (assign, nonatomic) BOOL keyboardShown;
- (void)hideKeyboard;
@end
