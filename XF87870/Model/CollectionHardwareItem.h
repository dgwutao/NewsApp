//
//  CollectionHardwareItem.h
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
//{"columnid":"11_0","description":"","evaluationid":"0","favid":"925","id":"15829","img":"","imgurl":"","name":"测试222","price":"100.0","shareurl":"http://172.16.16.20:5002/share/sharexw.aspx?id=15829","url":"http://www.taobao.com"}

@interface CollectionHardwareItem : NSObject
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *EvaluationId;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *Price;
@property (copy, nonatomic) NSString *FavId;
@property (copy, nonatomic) NSString *ShareUrl;
@property (copy, nonatomic) NSString *Url;


- (instancetype) initWithJson:(NSDictionary *)json;


@end
