//
//  UserManagedObject+CoreDataProperties.h
//  MyTest
//
//  Created by wangdongdong on 16/3/21.
//  Copyright © 2016年 Spark. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *mbtype;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *profileImageUrl;
@property (nullable, nonatomic, retain) NSString *screenName;
@property (nullable, nonatomic, retain) NSSet<StatusManagedObject *> *statuses;

@end

@interface UserManagedObject (CoreDataGeneratedAccessors)

- (void)addStatusesObject:(StatusManagedObject *)value;
- (void)removeStatusesObject:(StatusManagedObject *)value;
- (void)addStatuses:(NSSet<StatusManagedObject *> *)values;
- (void)removeStatuses:(NSSet<StatusManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
