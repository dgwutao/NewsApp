//
//  XFTabBarController.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFTabBarController.h"
#import "XFBaseNavigationController.h"
#import "DiscoveryViewController.h"
#import "HardwareViewController.h"
#import "CommunityViewController.h"
#import "MineViewController.h"

@interface XFTabBarController ()<UITabBarControllerDelegate>
{
    NSMutableArray<__kindof UIViewController*> *_controllers;
}
@end

@implementation XFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBar];
}

-(void)initTabBar
{
    self.CurrentIndex = 0;
    _controllers = [NSMutableArray arrayWithCapacity:4];

    DiscoveryViewController *viewController1 = [DiscoveryViewController new];
    viewController1.title = @"新闻资讯";
    XFBaseNavigationController *navigationController1 = [[XFBaseNavigationController alloc]initWithRootViewController:viewController1];
    [_controllers addObject:navigationController1];
    
    HardwareViewController *viewController2 = [HardwareViewController new];
    viewController2.title = @"硬件评测";
    XFBaseNavigationController *navigationController2 = [[XFBaseNavigationController alloc]initWithRootViewController:viewController2];
    [_controllers addObject:navigationController2];
    
    CommunityViewController *viewController3 = [CommunityViewController new];
    viewController3.title = @"社区";
    XFBaseNavigationController *navigationController3 = [[XFBaseNavigationController alloc]initWithRootViewController:viewController3];
    [_controllers addObject:navigationController3];
    
    MineViewController *viewController4 = [[MineViewController alloc]initWithNibName:@"MineViewController" bundle:nil];
    viewController4.title = @"我的";
    XFBaseNavigationController *navigationController4 = [[XFBaseNavigationController alloc]initWithRootViewController:viewController4];
    [_controllers addObject:navigationController4];
    
    self.viewControllers = _controllers;
    self.delegate = self;
    self.tabBar.selectionIndicatorImage = [self drawTabBarItemBackground];
    for (int i = 0;i < _controllers.count; i ++) {
        UIImage *normalImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabbar_%d_deflaut",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ic_tabbar_%d_sel",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        item.image = normalImage;
        item.selectedImage = selectedImage;
        if (i == 0) {
            item.title = @"发现";
        }
        else if (i == 1) {
            item.title = @"硬件";
        }else{
            item.title = [_controllers objectAtIndex:i].title;
        }
        NSDictionary *normalTitleAttr = @{NSForegroundColorAttributeName:[UIColor colorWithHexValue:0x8c8c8c alpha:1.0f],
                                          NSFontAttributeName:[UIFont systemFontOfSize:11.0f]};
        NSDictionary *selectedTitleAttr = @{NSForegroundColorAttributeName:[UIColor colorWithHexValue:0xffd800 alpha:1.0f],
                                            NSFontAttributeName:[UIFont systemFontOfSize:11.0f]};
        [item setTitleTextAttributes:normalTitleAttr forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedTitleAttr forState:UIControlStateSelected];
    }
}

- (UIImage*)drawTabBarItemBackground
{
    CGSize size = CGSizeMake(self.tabBar.bounds.size.width / self.tabBar.items.count, self.tabBar.bounds.size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark --UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = 0;
    for (UIViewController *controller in _controllers) {
        if (viewController == controller) {
            break;
        }
        index++;
    }
    switch (index) {
        case 0:
        {
            if (self.CurrentIndex != index) {
                self.CurrentIndex = index;
            }else{
                UINavigationController *nav = [_controllers objectAtIndex:index];
                DiscoveryViewController *discovery = (DiscoveryViewController*)nav.topViewController;
                [discovery jumpToTop];
            }
            break;
        }
        case 1:
        {
            if (self.CurrentIndex != index) {
                self.CurrentIndex = index;
            }
            break;
        }
        case 2:
        {
            if (self.CurrentIndex != index) {
                self.CurrentIndex = index;
            }
            break;
        }
        case 3:
        {
            if (self.CurrentIndex != index) {
                self.CurrentIndex = index;
            }
            break;
        }
        default:
            break;
    }
}


@end
