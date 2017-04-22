//
//  XFToastView.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFToastView.h"
#import "KSToastView.h"

@implementation XFToastView

+ (void) showTextToast:(NSString*)toast{
    [KSToastView ks_setAppearanceTextFont:[UIFont boldSystemFontOfSize:17.0f]];
    [KSToastView ks_setAppearanceMaxWidth:CGRectGetWidth([UIScreen mainScreen].bounds) - 64.0f];
    [KSToastView ks_setAppearanceOffsetBottom:[UIScreen mainScreen].bounds.size.height / 2];
    [KSToastView ks_setAppearanceMaxLines:2];
    [KSToastView ks_showToast:toast duration:1.5f];
}

@end
