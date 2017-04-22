//
//  XFBaseViewController.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFHttpRequestManger.h"

@interface XFBaseViewController : UIViewController
@property (strong, nonatomic) XFHttpRequestManger *sessionManager;

- (void) setRightNavItemWithImage:(NSString*)imagePath;
- (void) setRightNavItemWithTitle:(NSString*)title;
- (void) setLeftNavItemWithImage:(NSString *)imagePath;
- (void) setLeftNavItemWithTitle:(NSString *)title;
- (void) rightItemAction;
- (void) leftItemAction;
@end
