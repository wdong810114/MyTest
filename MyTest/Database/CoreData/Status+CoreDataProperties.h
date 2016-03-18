//
//  Status+CoreDataProperties.h
//  MyTest
//
//  Created by wangdongdong on 16/3/17.
//  Copyright © 2016年 Spark. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Status.h"

NS_ASSUME_NONNULL_BEGIN

@interface Status (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSString *source;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
