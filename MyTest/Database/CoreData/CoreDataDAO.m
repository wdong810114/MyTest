//
//  CoreDataDAO.m
//  MyTest
//
//  Created by wangdongdong on 16/3/18.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreDataDAO.h"

@implementation CoreDataDAO

@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;

// 返回被管理对象上下文
- (NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

// 返回持久化存储协调器
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"myDatabase.sqlite"];
    NSError *error = nil;
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"错误: %@", error.localizedDescription);
        abort();
    }
    return _persistentStoreCoordinator;
}

// 返回被管理对象模型
- (NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"myDatabase" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

#pragma mark - Core Data Saving support
- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if(managedObjectContext != nil) {
        NSError *error = nil;
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"错误: %@", error.localizedDescription);
            abort();
        }
    }
}

// 返回应用程序Documents目录的NSURL类型
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
