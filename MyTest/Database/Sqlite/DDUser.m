//
//  DDUser.m
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DDUser.h"

@implementation DDUser

- (DDUser *)initWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city
{
    if(self = [super init]) {
        self.name = name;
        self.screenName = screenName;
        self.profileImageUrl = profileImageUrl;
        self.mbtype = mbtype;
        self.city = city;
    }
    return self;
}

- (DDUser *)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (DDUser *)userWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city
{
    DDUser *user = [[DDUser alloc] initWithName:name screenName:screenName profileImageUrl:profileImageUrl mbtype:mbtype city:city];
    return user;
}

@end
