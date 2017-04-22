//
//  GameInfoItem.h
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameInfoItem : NSObject
//"gamegrade":"7.5",
//"gameinfo":{
//    "bagname":"",
//    "bagversions":"",
//    "columnid":"6_1",
//    "createdate":"2016-11-22",
//    "gamesize":"未知",
//    "gamesource":"",
//    "gametype":"暂无",
//    "id":"",
//    "img":"",
//    "imgurl":"",
//    "loadcondition":"",
//    "makefactory":"",
//    "name":"",
//    "shareurl":"http://172.16.16.20:5002/share/shareyx.aspx?id=15750",
//    "xingji":"0"
//},
@property (copy, nonatomic) NSString *BagName;
@property (copy, nonatomic) NSString *BagVersions;
@property (copy, nonatomic) NSString *ImageUrl;
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *CreateDate;
@property (copy, nonatomic) NSString *GameSize;
@property (copy, nonatomic) NSString *GameSource;
@property (copy, nonatomic) NSString *GameType;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *LoadCondition;
@property (copy, nonatomic) NSString *MakeFactory;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShareUrl;
@property (copy, nonatomic) NSString *XingJi;
- (instancetype) initWithJson:(NSDictionary*)json;
@end
