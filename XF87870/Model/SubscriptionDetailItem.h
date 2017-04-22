//
//  SubscriptionDetailItem.h
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

//"columnid":"3_1",
//"id":"15750",
//"img":"",
//"imgurl":"",
//"name":"宇宙大逃脱！极限烧脑游戏——《逃离太空站VR》评测",
//"shortname":"游戏评测",
//"tag":"发现"
@interface SubscriptionDetailItem : NSObject
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShortName;
@property (copy, nonatomic) NSString *Tag;


- (instancetype) initWithJson:(NSDictionary *)json;
@end
