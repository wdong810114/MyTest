//
//  Models.m
//  RuntimeTestOne
//
//  Created by HEYANG on 16/6/30.
//  Copyright © 2016年 HeYang. All rights reserved.
//

#import "Models.h"

/*@implementation CS_Connect

@end

@implementation CS_1000001

@end*/

@implementation BizData1

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"port", @"ip"];
    return [optionalProperties containsObject:propertyName];
}

@end

@implementation SC_1000000

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"templateNo", @"bizData", @"timeStamp", @"msgId"];
    return [optionalProperties containsObject:propertyName];
}

@end


@implementation BizData2

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"code", @"initialId", @"msg"];
    return [optionalProperties containsObject:propertyName];
}

@end

@implementation SC_1000001

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"templateNo", @"bizData", @"timeStamp", @"msgId"];
    return [optionalProperties containsObject:propertyName];
}

@end


@implementation BizData3

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"platform", @"initialId", @"channelKey", @"deviceId", @"version"];
    return [optionalProperties containsObject:propertyName];
}

@end

@implementation BizData4

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"code", @"msg"];
    return [optionalProperties containsObject:propertyName];
}

@end

@implementation CS_1000002

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"sign", @"templateNo", @"bizData", @"timeStamp", @"msgId", @"mchNo"];
    return [optionalProperties containsObject:propertyName];
}

@end

@implementation SC_1000002

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    NSArray *optionalProperties = @[@"sign", @"templateNo", @"bizData", @"timeStamp", @"msgId", @"mchNo"];
    return [optionalProperties containsObject:propertyName];
}

@end
