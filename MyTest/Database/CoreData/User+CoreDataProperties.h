//
//  User+CoreDataProperties.h
//  MyTest
//
//  Created by wangdongdong on 16/3/17.
//  Copyright © 2016年 Spark. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *mbtype;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *profileImageUrl;
@property (nullable, nonatomic, retain) NSString *screenName;
@property (nullable, nonatomic, retain) NSSet<Status *> *statuses;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addStatusesObject:(Status *)value;
- (void)removeStatusesObject:(Status *)value;
- (void)addStatuses:(NSSet<Status *> *)values;
- (void)removeStatuses:(NSSet<Status *> *)values;

@end

NS_ASSUME_NONNULL_END
