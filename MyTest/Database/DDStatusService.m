//
//  DDStatusService.m
//  Test001
//
//  Created by wangdongdong on 16/3/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DDStatusService.h"

#import "DDDbManager.h"
#import "DDUserService.h"

@implementation DDStatusService
DEFINE_SINGLETON_IMPLEMENTATION(DDStatusService)

- (void)addStatus:(DDStatus *)status
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Status (source,createdAt,\"text\",user) VALUES('%@','%@','%@','%@')", status.source, status.createdAt, status.text, status.user.Id];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (void)removeStatus:(DDStatus *)status
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM Status WHERE Id='%@'", status.Id];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (void)modifyStatus:(DDStatus *)status
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE Status SET source='%@',createdAt='%@',\"text\"='%@',user='%@' WHERE Id='%@'",status.source, status.createdAt, status.text, status.user, status.Id];
    [[DDDbManager sharedDDDbManager] executeNonQuery:sql];
}

- (DDStatus *)getStatusById:(int)Id
{
    DDStatus *status = [[DDStatus alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT Id,source,createdAt,\"text\",user FROM Status WHERE Id='%i'", Id];
    NSArray *rows = [[DDDbManager sharedDDDbManager] executeQuery:sql];
    if(rows && rows.count > 0) {
        [status setValuesForKeysWithDictionary:rows[0]];
        status.user = [[DDUserService sharedDDUserService] getUserById:[(NSNumber *)rows[0][@"user"] intValue]];
    }
    return status;
}

- (NSArray *)getAllStatus
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = @"SELECT Id,source,createdAt,\"text\",user FROM Status ORDER BY Id";
    NSArray *rows = [[DDDbManager sharedDDDbManager] executeQuery:sql];
    for(NSDictionary *dict in rows) {
        DDStatus *status = [self getStatusById:[(NSNumber *)dict[@"Id"] intValue]];
        [array addObject:status];
    }
    return array;
}

@end
