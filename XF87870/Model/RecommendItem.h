//
//  RecommendItem.h
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
//"columnid": "1_0",
//"id": "14480",
//"imageurl": "",
//"name": "《生化危机7》恐怖试玩放出 吓得你屁滚尿流！",
//"shortname": "VR游戏",
//"tag": "新闻"
@interface RecommendItem : NSObject
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImageUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShortName;
@property (copy, nonatomic) NSString *Tag;

- (instancetype) initWithJson:(NSDictionary*)json;
@end
