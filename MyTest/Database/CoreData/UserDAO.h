//
//  UserDAO.h
//  MyTest
//
//  Created by wangdongdong on 16/3/18.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreDataDAO.h"

#import "UserManagedObject.h"
#import "StatusManagedObject.h"
#import "User.h"
#import "Status.h"

@interface UserDAO : CoreDataDAO

- (void)addUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;
- (void)removeUser:(UserManagedObject *)user;
- (void)modifyUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;
- (UserManagedObject *)getUserByName:(NSString *)name;
- (NSArray *)findAll;
//- (NSArray *)getStatusesByUserName:(NSString *)name;
//- (NSArray *)getUsersByStatusText:(NSString *)text screenName:(NSString *)screenName;

@end
