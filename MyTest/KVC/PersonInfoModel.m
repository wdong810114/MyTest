//
//  PersonInfoModel.m
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "PersonInfoModel.h"

@implementation PersonInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]) {
        self.myID = value;
    }
}

@end
