//
//  UIColor+Extension.m
//  AutoOwnersHome
//
//  Created by mac on 17-10-23.
//  Copyright (c) 2017年 mac. All rights reserved.
//

#import "UIColor+Extention.h"

@implementation UIColor(Extenstion)

+ (CGFloat)redColorFromHexRGBColor:(NSInteger)color {
    return (((color & 0xff0000) >> 16) / 255.0);
}

+ (CGFloat)greenColorFromRGBColor:(NSInteger)color {
    return (((color & 0x00ff00) >> 8) / 255.0);
}

+ (CGFloat)blueColorFromRGBColor:(NSInteger)color {
    return ((color & 0x0000ff) / 255.0);
}

+ (UIColor *)colorWithHexValue:(NSInteger)color alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:[UIColor redColorFromHexRGBColor:color]
                           green:[UIColor greenColorFromRGBColor:color]
                            blue:[UIColor blueColorFromRGBColor:color]
                           alpha:alpha];
}

- (void)getColorComponentsWithRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:red green:green blue:blue alpha:alpha];
    }else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        *red = components[0];
        *green = components[1];
        *blue = components[2];
        *alpha = components[3];
    }
}

@end
