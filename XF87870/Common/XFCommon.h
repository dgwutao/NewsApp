//
//  XFCommon.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#ifndef XFCommon_h
#define XFCommon_h

#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:%d (%@)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define RootUrl @""
#else
#define DebugLog( s, ... )
#define RootUrl @""
#endif
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE ([UIScreen mainScreen].bounds.size.width/320)

#define BoutiquecaInfo @"/api/appv2/boutiquecainfo.ashx" //精品栏目分类列表
#define BoutiqueInfo @"/api/appv2/boutiqueinfo.ashx" //精品栏目信息列表
#define FindInfo @"/api/appv2/findinfo.ashx" //发现信息列表
#define CommentInfo @"/api/appv2/commentinfo.ashx" //获取评论列表
#define AddComment @"/api/appv2/addcomment.ashx" //添加评论
#define DeleteComment @"/api/appv2/deletecomment.ashx" //删除评论
#define CommentLike @"/api/appv2/commentlike.ashx" //评论点赞
#define InfoDetail @"/api/appv2/infodetail.ashx" //获取新闻详细信息
#define EvaluationInfoDetail @"/api/appv2/evaluationinfodetail.ashx" //获取评测详细信息
#define VrgameInfoDetail @"/api/appv2/vrgameinfodetail.ashx" //获取VR游戏详细信息
#define OrdinaryGameInfoDetail @"/api/appv2/ordinarygameinfodetail.ashx" //获取普通游戏详细信息
#define VideoInfoDetail @"/api/appv2/videoinfodetail.ashx" //获取视频详细信息
#define BoutiqueInfoDetail @"/api/appv2/boutiqueinfodetail.ashx" //获取精品栏目详细信息
#define VrgamecaInfo @"/api/appv2/vrgamecainfo.ashx" //获取VR游戏分类信息
#define OrdinaryGamecaInfo @"/api/appv2/ordinarygamecainfo.ashx" //获取普通游戏分类信息
#define VrgameRankingInfo @"/api/appv2/vrgamerankinginfo.ashx" //获取vr游戏排行榜信息
#define OrdinaryGameRankingInfo @"/api/appv2/ordinarygamerankinginfo.ashx" //获取普通游戏排行榜信息
#define VrgameInfo @"/api/appv2/vrgameinfo.ashx" //获取vr游戏列表
#define SearchGameInfo @"/api/appv2/searchgameinfo.ashx" //搜索游戏列表
#define OrdinaryGameInfo @"/api/appv2/ordinarygameinfo.ashx" //获取普通游戏列表
#define EvaluationInfo @"/api/appv2/evaluationinfo.ashx" //获取评测列表
#define HardwarecaInfo @"/api/appv2/hardwarecainfo.ashx" //获取硬件库分类
#define HardwarePriceInfo @"/api/appv2/hardwarepriceinfo.ashx" //获取硬件价格分类
#define HardwareInfo @"/api/appv2/hardwareinfo.ashx" //获取硬件库列表
#define HardwareInfoDetail @"/api/appv2/hardwareinfodetail.ashx" //获取硬件评测详细信息
#define InfoLike @"/api/appv2/infolike.ashx" //信息点赞
#define AddFavoriteInfo @"/api/appv2/addfavoriteinfo.ashx" //添加收藏
#define FavoriteInfo @"/api/appv2/favoriteinfo.ashx" //获取收藏列表
#define DeleteFavoriteInfo @"/api/appv2/deletefavoriteinfo.ashx" //删除收藏
#define AddFavoriteAdminInfo @"/api/appv2/addfavoriteadmininfo.ashx" //添加订阅
#define FavoriteAdminInfo @"/api/appv2/favoriteadmininfo.ashx" //获取订阅列表
#define DeleteFavoriteAdminInfo @"/api/appv2/deletefavoriteadmininfo.ashx" //删除订阅
#define ImageSwitchInfo @"/api/appv2/imageswitchinfo.ashx" //获取图片切换列表
#define HardwareActivity @"/api/appv2/hardwareactivity.ashx" //获取硬件活动列表
#define GameAreaca @"/api/appv2/gameareaca.ashx" //获取游戏专题分类列表
#define GameAreaInfo @"/api/appv2/gameareainfo.ashx" //获取游戏专题列表
#define FavoriteAdminSendInfo @"/api/appv2/favoriteadminsendinfo.ashx"
#define MyCommentInfo @"/api/appv2/mycommentinfo.ashx"
#define AddFeedback @"/api/app/addfeedback.ashx"

#define kQQSDKAppId @"101289184"
#define kQQSDKAppSecret @"4737469a0876b8764f48d31a6d185f38"

#define kWeiboSDKAppKey @"2268707844"
#define kWeiboSDKAppSecret @"a7ddc9f94f8676bbe599e9b60b1b3b7c"

#define kWeChatAppId  @"wx9fedc7dcca5daf19"
#define kWeChatAppSecret @"7ad285d19ab2573b374dc329e82ab6fd"

#define CommunityUrl @"http://appbbs.game.87870.com"
#define DefaultAvatar @"pic_profile_user_unbound"
#define DefaultUid @"1481701879"

#define dispatch_main_async_safe(block)\
           if ([NSThread isMainThread]) {\
              block();\
           } else {\
              dispatch_async(dispatch_get_main_queue(), block);\
           }

#define dispatch_async_on_global(block)\
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block)

//栏目字段说明
//columnid:1_0 代表新闻分类
//columnid:2_0 代表视频分类
//columnid:3_1 代表游戏评测分类
//columnid:3_2 代表硬件评测分类
//columnid:6_1 代表vr游戏分类
//columnid:6_2 代表普通游戏分类
//columnid:7_0 精品栏目详情页
//columnid:7_1 代表精品栏目（含视频）
//columnid:7_2 代表精品栏目（不含视频）
//columnid:11_0 代表硬件库
//涉及到大分类数据筛选的  1代表发现 2代表游戏 3代表硬件



#import "XFToastView.h"
#import "XFLoadingView.h"
#import "NSString+Extension.h"
#import "XFFileManager.h"
#import "XFUtil.h"
#import "UIColor+Extention.h"
#import "XFBannerView.h"
#import "XFCommonFunc.h"
#import "XFFileCache.h"
#endif
