//
//  Store.h
//  CoreDataMultithread
//
//  Created by axel on 16/5/17.
//  Copyright © 2016年 axel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Common.h"

@interface DBStore : NSObject
@property (strong, nonatomic) NSManagedObjectContext *mainQueueContext;
@property (strong, nonatomic) NSManagedObjectContext *privateQueueContext;

@end
