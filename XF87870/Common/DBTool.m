//
//  DBbase.m
//  LongWan
//
//  Created by xf on 2017/1/3.
//  Copyright © 2017年 liguohui. All rights reserved.
//

#import "DBTool.h"

@interface DBTool()
@property (strong, nonatomic) DBStore *store;

@end

@implementation DBTool

static DBTool *_instance = nil;

+ (instancetype)sharedInstance {
    DBTool *instance = [[self alloc] init];
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (void)loadAllEntity:(NSString*)entity success:(void(^)(NSArray* entites))success
{
    NSManagedObjectContext *context = self.store.mainQueueContext;
    [context performBlockAndWait:^{
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
        [request setEntity:description];
        NSError *error;
        NSArray *entities = [context executeFetchRequest:request error:&error];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(entities);
            });
        }
    }];
}

- (void)insertEntity:(id)entity formate:(void(^)(id obj))formater
{
    NSManagedObjectContext *context = self.store.privateQueueContext;
    [context performBlockAndWait:^{
        id description = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
        if (formater) {
            formater(description);
        }
        NSError *error;
        if (![context save:&error]) {
            DebugLog(@"%@",error.localizedDescription);
        }
    }];
}

- (DBStore*)store
{
    if (!_store) {
        _store = [[DBStore alloc]init];
    }
    return _store;
}


- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}
@end
