//
//  AppGuideView.h
//
//
//  Created by xf on 17/10/24.
//  Copyright (c) 2017年 xf. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UserGuideViewDelegate <NSObject>

-(void) skipGuideView;

@end

@interface AppGuideView : UIView

@property (strong, nonatomic) NSArray *guideImages;

@property (copy, nonatomic) void(^guideBlock)(int index);

@property (copy, nonatomic) void(^scrollEndBlock)(void);
@end
