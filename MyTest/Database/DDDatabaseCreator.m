//
//  DDDatabaseCreator.m
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DDDatabaseCreator.h"

#import "DDDbManager.h"

@implementation DDDatabaseCreator

+ (void)initDatabase
{
    NSString *key = @"IsCreatedDb";
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if([[defaults valueForKey:key] integerValue] != 1) {
        [self createUserTable];
        [self createStatusTable];
        [defaults setValue:@1 forKey:key];
    }
}

+ (void)createUserTable
{
    NSString *sql = @"CREATE TABLE User (Id integer PRIMARY KEY AUTOINCREMENT,name text,screenName text,profileImageUrl text,mbtype text,city text)";
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

+ (void)createStatusTable
{
    NSString *sql=@"CREATE TABLE Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

@end
