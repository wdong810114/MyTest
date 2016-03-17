//
//  DDDbManager.h
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>
#import "DDSingleton.h"

@interface DDDbManager : NSObject
DEFINE_SINGLETON_HEADER(DDDbManager);

@property (nonatomic) sqlite3 *database;

- (void)openDb:(NSString *)dbname;
- (void)executeNonQuery:(NSString *)sql;
- (NSArray *)executeQuery:(NSString *)sql;

@end
