//
//  CoreDataDAO.h
//  MyTest
//
//  Created by wangdongdong on 16/3/18.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface CoreDataDAO : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
