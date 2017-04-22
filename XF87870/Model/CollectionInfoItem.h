//
//  CollectionInfoItem.h
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionInfoItem : NSObject
//"columnid":"1_0",
//"favid":"913",
//"id":"15823",
//"img":"",
//"imgurl":"",
//"name":"【悲报】这可能是我见过最烂的VR游戏了…",
//"shortname":"VR游戏",
//"tag":"发现"

@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShortName;
@property (copy, nonatomic) NSString *Tag;
@property (copy, nonatomic) NSString *FavId;


- (instancetype) initWithJson:(NSDictionary *)json;
@end
