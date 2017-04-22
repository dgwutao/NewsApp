//
//  DBbase.h
//  LongWan
//
//  Created by xf on 2017/1/3.
//  Copyright © 2017年 liguohui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBStore.h"
#import "Post+CoreDataClass.h"
#import <CoreData/CoreData.h>
#import "Common.h"

@interface DBTool : NSObject<NSCopying,NSMutableCopying>
+ (instancetype)sharedInstance;


- (void)loadAllEntity:(NSString*)entity success:(void(^)(NSArray* entites))success;
- (void)insertEntity:(id)entity formate:(void(^)(id obj))formater;
@end
