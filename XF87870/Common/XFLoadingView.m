//
//  XFLoadingView.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFLoadingView.h"

@interface XFLoadingView()
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation XFLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.indicatorView.frame = CGRectMake(0, 0, 20, 20);
    self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

+ (void)show {
    XFLoadingView *loadingView = nil;
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[XFLoadingView class]]) {
            loadingView = (XFLoadingView *)subView;
            [loadingView.indicatorView startAnimating];
            break;
        }
    }
    if (!loadingView) {
        loadingView = [[XFLoadingView alloc] init];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        CGRect frame = CGRectMake(0, 0, 20, 20);
        loadingView.frame = frame;
        loadingView.center = keyWindow.center;
        [loadingView.indicatorView startAnimating];
        [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    }
}

+ (void)hide {
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[XFLoadingView class]]) {
            XFLoadingView *loadingView = (XFLoadingView *)subView;
            [loadingView.indicatorView stopAnimating];
            [subView removeFromSuperview];
            break;
        }
    }
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

@end
