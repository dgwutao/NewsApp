//
//  XFBaseWebViewController.h
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface XFBaseWebViewController : XFBaseViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) BOOL isKeyboardShown;
@end
