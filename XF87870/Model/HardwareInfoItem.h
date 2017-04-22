//
//  HardwareInfoItem.h
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HardwareInfoItem : NSObject
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShareUrl;
@property (copy, nonatomic) NSString *Comment;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *EvaluationId;
@property (copy, nonatomic) NSString *IsLike;
@property (copy, nonatomic) NSString *Price;
@property (copy, nonatomic) NSString *Url;

-(instancetype) initWithJson:(NSDictionary*)json;
@end
