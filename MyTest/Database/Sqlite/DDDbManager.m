//
//  DDDbManager.m
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DDDbManager.h"

#ifndef kDatabaseName
#define kDatabaseName @"SqliteDatabase.db"
#endif

@implementation DDDbManager
DEFINE_SINGLETON_IMPLEMENTATION(DDDbManager)

- (instancetype)init
{
    DDDbManager *manager;
    if((manager = [super init])) {
        [manager openDb:kDatabaseName];
    }
    
    return manager;
}

- (void)openDb:(NSString *)dbname
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:dbname];
    NSLog(@"filePath: %@", filePath);
    if(SQLITE_OK == sqlite3_open(filePath.UTF8String, &_database)) {
        NSLog(@"数据库打开成功!");
    } else {
        NSLog(@"数据库打开失败!");
    }
}

- (void)executeNonQuery:(NSString *)sql
{
    char *error;
    if(SQLITE_OK != sqlite3_exec(_database, sql.UTF8String, NULL, NULL, &error)) {
        NSLog(@"执行SQL语句过程中发生错误！错误信息：%s", error);
    }
}

- (NSArray *)executeQuery:(NSString *)sql
{
    NSMutableArray *rows = [NSMutableArray array];
    sqlite3_stmt *stmt;
    if(SQLITE_OK == sqlite3_prepare_v2(_database, sql.UTF8String, -1, &stmt, NULL)) {
        while(SQLITE_ROW == sqlite3_step(stmt)) {
            int columnCount = sqlite3_column_count(stmt);
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for(int i = 0; i < columnCount; i++) {
                const char *name = sqlite3_column_name(stmt, i);
                const unsigned char *value = sqlite3_column_text(stmt, i);
                dict[[NSString stringWithUTF8String:name]] = [NSString stringWithUTF8String:(const char *)value];
            }
            [rows addObject:dict];
        }
    }
    sqlite3_finalize(stmt);
    
    return rows;
}

@end
