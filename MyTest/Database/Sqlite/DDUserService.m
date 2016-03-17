//
//  DDUserService.m
//  Test001
//
//  Created by wangdongdong on 16/3/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DDUserService.h"

#import "DDDbManager.h"

@implementation DDUserService
DEFINE_SINGLETON_IMPLEMENTATION(DDUserService)

- (void)addUser:(DDUser *)user
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO User (name,screenName,profileImageUrl,mbtype,city) VALUES('%@','%@','%@','%@','%@')", user.name, user.screenName, user.profileImageUrl, user.mbtype, user.city];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (void)removeUser:(DDUser *)user
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM User WHERE Id='%@'", user.Id];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (void)removeUserByName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM User WHERE name='%@'", name];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (void)modifyUser:(DDUser *)user
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE User SET name='%@',screenName='%@',profileImageUrl='%@',mbtype='%@',city='%@' WHERE Id='%@'", user.name, user.screenName, user.profileImageUrl, user.mbtype, user.city, user.Id];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (DDUser *)getUserById:(int)Id
{
    DDUser *user = [[DDUser alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT Id,name,screenName,profileImageUrl,mbtype,city FROM User WHERE Id='%i'", Id];
    NSArray *rows = [[DDDbManager sharedDDDbManager] executeQuery:sql];
    if(rows && rows.count > 0) {
        [user setValuesForKeysWithDictionary:rows[0]];
    }
    return user;
}

- (DDUser *)getUserByName:(NSString *)name
{
    DDUser *user = [[DDUser alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT Id,name,screenName,profileImageUrl,mbtype,city FROM User WHERE name='%@'", name];
    NSArray *rows = [[DDDbManager sharedDDDbManager] executeQuery:sql];
    if(rows && rows.count > 0) {
        [user setValuesForKeysWithDictionary:rows[0]];
    }
    return user;
}

@end
