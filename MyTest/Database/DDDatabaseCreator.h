//
//  DDDatabaseCreator.h
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDDatabaseCreator : NSObject

+ (void)initDatabase;
+ (void)createUserTable;
+ (void)createStatusTable;

@end
