//
//  UserDAO.m
//  MyTest
//
//  Created by wangdongdong on 16/3/18.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "UserDAO.h"

#import "Status.h"

@implementation UserDAO

- (void)addUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city
{
    UserManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [user setValue:name forKey:@"name"];
    [user setValue:screenName forKey:@"screenName"];
    [user setValue:profileImageUrl forKey:@"profileImageUrl"];
    [user setValue:mbtype forKey:@"mbtype"];
    [user setValue:city forKey:@"city"];
    [self saveContext];
}

- (void)removeUser:(UserManagedObject *)user
{
    [self.managedObjectContext deleteObject:user];
    [self saveContext];
}

- (void)modifyUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city
{
    UserManagedObject *user = [self getUserByName:name];
    [user setValue:screenName forKey:@"screenName"];
    [user setValue:profileImageUrl forKey:@"profileImageUrl"];
    [user setValue:mbtype forKey:@"mbtype"];
    [user setValue:city forKey:@"city"];
    [self saveContext];
}

- (UserManagedObject *)getUserByName:(NSString *)name
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"name=%@", name];
    NSArray *listData = [self.managedObjectContext executeFetchRequest:request error:nil];
    if(listData.count > 0) {
        return (UserManagedObject *)[listData lastObject];
    }
    
    return nil;
}

- (NSArray *)findAll
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray *listData = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *resListData = [NSMutableArray array];
    for(UserManagedObject *user in listData) {
        User *userObj = [[User alloc] init];
        userObj.name = user.name;
        userObj.screenName = user.screenName;
        userObj.profileImageUrl = user.profileImageUrl;
        userObj.mbtype = user.mbtype;
        userObj.city = user.city;
        [resListData addObject:userObj];
    }
    
    return resListData;
}

//- (NSArray *)getStatusesByUserName:(NSString *)name
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Status"];
//    request.predicate = [NSPredicate predicateWithFormat:@"user.name=%@", name];
//    NSArray *listData = [self.managedObjectContext executeFetchRequest:request error:nil];
//    NSMutableArray *resListData = [NSMutableArray array];
//    for(StatusManagedObject *status in listData) {
//        Status *statusObj = [[Status alloc] init];
//        statusObj.createdAt = status.createdAt;
//        statusObj.source = status.source;
//        statusObj.text = status.text;
//
//        UserManagedObject *user = [self getUserByName:name];
//
//        if(user) {
//            User *userObj = [[User alloc] init];
//            userObj.name = user.name;
//            userObj.screenName = user.screenName;
//            userObj.profileImageUrl = user.profileImageUrl;
//            userObj.mbtype = user.mbtype;
//            userObj.city = user.city;
//            statusObj.user = userObj;
//        } else {
//            statusObj.user = nil;
//        }
//
//        [resListData addObject:statusObj];
//    }
//    
//    return resListData;
//}
//
//- (NSArray *)getUsersByStatusText:(NSString *)text screenName:(NSString *)screenName
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Status"];
//    request.predicate = [NSPredicate predicateWithFormat:@"text LIKE '*Watch*'", text];
//    NSArray *statuses = [self.managedObjectContext executeFetchRequest:request error:nil];
//    
//    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"user.screenName=%@", screenName];
//    NSArray *stats = [statuses filteredArrayUsingPredicate:userPredicate];
//    return stats;
//}

@end
