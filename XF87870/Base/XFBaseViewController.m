//
//  XFBaseViewController.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"

@interface XFBaseViewController ()

@end

@implementation XFBaseViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) setRightNavItemWithImage:(NSString *)imagePath{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagePath] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
}

- (void) setRightNavItemWithTitle:(NSString *)title{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
}

- (void)rightItemAction{
    
}

- (void) setLeftNavItemWithImage:(NSString *)imagePath{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagePath] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
}

- (void) setLeftNavItemWithTitle:(NSString *)title{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
}

- (void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (XFHttpRequestManger*) sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[XFHttpRequestManger alloc]init];
    }
    return _sessionManager;
}

- (void)dealloc {
    if (_sessionManager) {
        [_sessionManager cancelAllTask];
    }
    DebugLog(@"%@没有造成循环引用", [self class]);
}

@end
