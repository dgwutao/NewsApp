//
//  CommunityViewController.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommunityViewController.h"
#import "SearchViewController.h"

@interface CommunityViewController ()
{
    UIBarButtonItem *_backItem;
}

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setRightNavItemWithImage:@"ic_nav_search"];
    _backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemAction)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CommunityUrl]]];
    [self configWebCookie];
}

- (void)configWebCookie
{
    NSDictionary *cookies = @{@"userid":@"-1",
                              @"username":@"-1",
                              @"usertoken":@"-1",
                              @"bbsapp":@"-1"};
    NSHTTPCookie *httpCookie = [NSHTTPCookie cookieWithProperties:cookies];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:httpCookie];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    if ([self.webView canGoBack]) {
        self.navigationItem.leftBarButtonItem = _backItem;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void) rightItemAction{
    SearchViewController *controller = [SearchViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) backItemAction
{
    if (self.isKeyboardShown) {
        self.isKeyboardShown = NO;
        [self.webView endEditing:YES];
    }
    else if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

@end
