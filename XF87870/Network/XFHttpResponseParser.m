//
//  XFHttpResponseParser.m
//  XF87870
//
//  Created by xf on 2016/11/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFHttpResponseParser.h"
#import "FindListItem.h"
#import "BannerItem.h"
#import "SubBannerItem.h"
#import "HardwarecaItem.h"
#import "EvaluationInfoItem.h"
#import "HardwareInfoItem.h"
#import "BoutiqueInfoItem.h"
#import "FeedDetailItem.h"
#import "CommentItem.h"
#import "SubscriptionItem.h"
#import "SubscriptionDetailItem.h"
#import "CollectionInfoItem.h"
#import "CollectionHardwareItem.h"
#import "MyCommentInfoItem.h"

static XFHttpResponseParser *_instance;

@implementation XFHttpResponseParser

+ (instancetype)sharedParser {
    XFHttpResponseParser *instance = [[self alloc] init];
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (responseParser) SubBannerParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            SubBannerItem *subBanner = [[SubBannerItem alloc]initWithJson:item];
            [arr addObject:subBanner];
        }
        return arr;
    };
}

- (responseParser) ImageSwitchInfoParser
{
    //{"result":{"msg":"SUCCESS","ret":"0"},"version":"2.0","zparam":null,"infolist":[{"columnid":"1","id":"","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/4e5d1f0e-142d-497e-bd63-a821b3b0c689.jpg","name":"测试222","type":"1","url":""},{"columnid":"2","id":"2","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/8ab5426a-0185-400a-a312-8677cc7dc6c5.jpg","name":"测试111","type":"2","url":""}]}
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            BannerItem *banner = [[BannerItem alloc]initWithJson:item];
            [arr addObject:banner];
        }
        return arr;
    };
}

- (responseParser) FindInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            FindListItem *findInfo = [[FindListItem alloc]initWithJson:item];
            [arr addObject:findInfo];
        }
        return arr;
    };
}

- (responseParser) UserActionParser
{
    return ^(NSDictionary *json){
        NSDictionary *result = [json objectForKey:@"result"];
        return result;
    };
}

- (responseParser) CommentInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            CommentItem *findInfo = [[CommentItem alloc]initWithJson:item];
            [arr addObject:findInfo];
        }
        return arr;
    };
}

- (responseParser) SubscriptionParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            SubscriptionItem *subscription = [[SubscriptionItem alloc]initWithJson:item];
            [arr addObject:subscription];
        }
        return arr;
    };
}

- (responseParser) MyCommentParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            MyCommentInfoItem *commentInfo = [[MyCommentInfoItem alloc]initWithJson:item];
            [arr addObject:commentInfo];
        }
        return arr;
    };
}

- (responseParser) SubscriptionDetailParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            SubscriptionDetailItem *subscription = [[SubscriptionDetailItem alloc]initWithJson:item];
            [arr addObject:subscription];
        }
        return arr;
    };
}

- (responseParser) CollectionInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            CollectionInfoItem *subscription = [[CollectionInfoItem alloc]initWithJson:item];
            [arr addObject:subscription];
        }
        return arr;
    };
}

- (responseParser) CollectionHardwareParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *hardwarelist = [json objectForKey:@"hardwarelist"];
        for (NSDictionary *item in hardwarelist) {
            CollectionHardwareItem *subscription = [[CollectionHardwareItem alloc]initWithJson:item];
            [arr addObject:subscription];
        }
        return arr;
    };
}

- (responseParser) FeedInfoDetailParser
{
    return ^(NSDictionary *json){
        NSDictionary *infolist = [json objectForKey:@"infolist"];
        FeedDetailItem *feedDetail = [[FeedDetailItem alloc]initWithJson:infolist];
        return feedDetail;
    };
}

- (responseParser) BoutiqueInfoDetailParser
{
    return ^(NSDictionary *json){
        NSDictionary *infolist = [json objectForKey:@"infolist"];
        FeedDetailItem *feedDetail = [[FeedDetailItem alloc]initWithJson:infolist];
        return feedDetail;
    };
}


- (responseParser) BoutiqueInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            BoutiqueInfoItem *findInfo = [[BoutiqueInfoItem alloc]initWithJson:item];
            [arr addObject:findInfo];
        }
        return arr;
    };
}

//  hardwarecainfo    {"result":{"msg":"SUCCESS","ret":"0"},"version":"2.0","zparam":null,"infolist":[{"cid":"1000001","name":"VR盒子"},{"cid":"1000002","name":"VR一体机"},{"cid":"1000003","name":"VR头盔"}]}
- (responseParser) HardwarecaInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            HardwarecaItem *findInfo = [[HardwarecaItem alloc]initWithJson:item];
            [arr addObject:findInfo];
        }
        return arr;
    };
}
//"columnid":"11_0",
//"comment":"0",
//"description":"2222222222222222222222222222",
//"evaluationid":"0",
//"id":"15053",
//"img":"1cc58bd4-26f5-48e3-a703-4dcd54a6513b.jpg",
//"imgurl":"http://pic.87870.com/upload/images/vr87870/2016/11/2/",
//"islike":"0",
//"name":"在萨斯打扫打扫打扫打扫大",
//"price":"100.0",
//"shareurl":"http://172.16.16.20:5002/share/sharexw.aspx?id=15053",
//"url":"http://game.87870.com/nhbcg/"

- (responseParser) HardwareInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            HardwareInfoItem *findInfo = [[HardwareInfoItem alloc]initWithJson:item];
            [arr addObject:findInfo];
        }
        return arr;
    };
}

//  EvaluationInfo    {"result":{"msg":"SUCCESS","ret":"0"},"version":"1.0","zparam":null,"infolist":[{"columnid":"3_2","id":"15831","img":"0640fb50-ea98-4e5d-84f4-1b81054bdecd.jpg","imgurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/0640fb50-ea98-4e5d-84f4-1b81054bdecd.jpg","name":"第一公会","shareurl":"http://172.16.16.20:5002/share/sharepc.aspx?id=15831"},{"columnid":"3_2","id":"8087","img":"","imgurl":"","name":"乐视VR移动头盔“LeVR COOL 1”初体验","shareurl":"http://172.16.16.20:5002/share/sharepc.aspx?id=8087"}],"number":"2","page":"1"}
- (responseParser) EvaluationInfoParser
{
    return ^(NSDictionary *json){
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *infolist = [json objectForKey:@"infolist"];
        for (NSDictionary *item in infolist) {
            EvaluationInfoItem *findInfo = [[EvaluationInfoItem alloc]initWithJson:item];
            [arr addObject:findInfo];
        }
        return arr;
    };
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
