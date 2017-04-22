//
//  BannerView.h
//  XF87870
//
//  Created by xf on 2016/11/11.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *showAllButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@end
