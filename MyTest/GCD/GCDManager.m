//
//  GCDManager.m
//  MyTest
//
//  Created by wangdongdong on 16/7/1.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "GCDManager.h"

@implementation GCDManager

+ (GCDManager *)sharedManager
{
    // dispatch_once_t，必须是全局或static变量
    
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    
    return instance;
}

- (void)print
{
    NSLog(@"Singleton");
}

@end
