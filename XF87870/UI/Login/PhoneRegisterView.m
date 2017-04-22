//
//  PhoneRegisterView.m
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "PhoneRegisterView.h"

@implementation PhoneRegisterView

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == self) {
//        return nil;
//    }else{
//        return view;
//    }
//    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden) {
//        return nil;
//    }
//    BOOL inside = [self pointInside:point withEvent:event];
//    UIView *hitView = nil;
//    if (inside) {
//        NSEnumerator *enumerator = [self.subviews reverseObjectEnumerator];
//        for (UIView *subview in enumerator) {
//            hitView = [subview hitTest:point withEvent:event];
//            if (hitView) {
//                break;
//            }
//        }
//        if (!hitView) {
//            hitView = self;
//        }
//        return hitView;
//    } else {
//        return nil;
//    }
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.pwdTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
}

@end
