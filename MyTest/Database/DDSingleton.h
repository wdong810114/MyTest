//
//  DDSingleton.h
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#define DEFINE_SINGLETON_HEADER(className) \
+ (className *)shared##className;

#define DEFINE_SINGLETON_IMPLEMENTATION(className) \
static className *shared##className = nil; \
static dispatch_once_t pred; \
\
+ (className *)shared##className { \
    dispatch_once(&pred, ^{ \
        shared##className = [[super allocWithZone:NULL] init]; \
    }); \
    return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
    return [self shared##className]; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
    return self; \
}
