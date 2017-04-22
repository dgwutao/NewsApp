//
//  AppDelegate.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "AppDelegate.h"
#import "XFTabBarController.h"
#import "AFNetworking.h"
#import "UMMobClick/MobClick.h"
#import <UMSocialCore/UMSocialCore.h>
#import "AppGuideView.h"

#define kAppKeyUmeng @"584f48ff75ca3521a4000cb6"
#define kVersionInUserdefaultkey @"com.87870.version.key"
@interface AppDelegate ()
@property (strong, nonatomic) AppGuideView *guideView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexValue:0x2c3039 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithHexValue:0x2c3039 alpha:1.0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onWindowVisibleNotification:)
                                                 name:UIWindowDidBecomeVisibleNotification
                                               object:nil];
    [self startNetworkStatusMonitor];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[XFTabBarController alloc] init];
    [self.window makeKeyAndVisible];

    [self startUMengAnalyze];
    [self configUMengSocial];
    return YES;
}

- (void) startNetworkStatusMonitor
{
    [AFNetworkReachabilityManager.sharedManager startMonitoring];
    [AFNetworkReachabilityManager.sharedManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
            default:
                break;
        }
    }];
}

- (void) startUMengAnalyze
{
    UMConfigInstance.appKey = kAppKeyUmeng;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#else
    [MobClick setLogEnabled:NO];
#endif
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}

- (void) configUMengSocial
{
#ifdef DEBUG
    [[UMSocialManager defaultManager] openLog:YES];
#else
    [[UMSocialManager defaultManager] openLog:NO];
#endif
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:kAppKeyUmeng];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWeChatAppId appSecret:kWeChatAppSecret redirectURL:@"http://87870.com"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQSDKAppId  appSecret:nil redirectURL:@"http://87870.com"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kWeiboSDKAppKey  appSecret:kWeiboSDKAppSecret redirectURL:@"http://account.87870.com/sina/app.ashx"];
}

#pragma mark - Notification Methods
- (void)onWindowVisibleNotification:(NSNotification *)note
{
    if (note.object == self.window) {
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *versionInUserdefault = [[NSUserDefaults standardUserDefaults]objectForKey:kVersionInUserdefaultkey];
        if (![currentVersion isEqualToString:versionInUserdefault]) {
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionInUserdefaultkey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.guideView = [[AppGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            __weak typeof (self) weakSelf = self;
            self.guideView.scrollEndBlock = ^(){
                [weakSelf performSelectorOnMainThread:@selector(removeGuideView) withObject:nil waitUntilDone:NO];
            };
            
            NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
            for (NSInteger i = 1; i < 5; i++) {
                NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"pic_guide%zi", i] ofType:@"png"];
                [images addObject:[UIImage imageWithContentsOfFile:path]];
            }
            self.guideView.guideImages = images;
            [self.window addSubview:self.guideView];
        }
    }
}

- (void) removeGuideView{
    if (self.guideView) {
        __weak typeof (self) weakSelf = self;
        [weakSelf.guideView removeFromSuperview];
        weakSelf.guideView = nil;
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {

    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
