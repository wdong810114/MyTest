//
//  DDStatus.m
//  Test001
//
//  Created by wangdongdong on 16/3/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DDStatus.h"

@implementation DDStatus

- (DDStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(DDUser *)user
{
    if(self = [super init]) {
        self.createdAt = createAt;
        self.source = source;
        self.text = text;
        self.user = user;
    }
    return self;
}

- (DDStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId
{
    if(self = [super init]) {
        self.createdAt = createAt;
        self.source = source;
        self.text = text;
        DDUser *user = [[DDUser alloc] init];
        user.Id = [NSNumber numberWithInt:userId];
        self.user = user;
    }
    return self;
}

- (DDStatus *)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.user = [[DDUser alloc] init];
        self.user.Id = dict[@"user"];
    }
    return self;
}

- (NSString *)source
{
    return [NSString stringWithFormat:@"来自 %@", _source];
}

+ (DDStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(DDUser *)user
{
    DDStatus *status = [[DDStatus alloc] initWithCreateAt:createAt source:source text:text user:user];
    return status;
}

+ (DDStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId
{
    DDStatus *status = [[DDStatus alloc] initWithCreateAt:createAt source:source text:text userId:userId];
    return status;
}

@end
