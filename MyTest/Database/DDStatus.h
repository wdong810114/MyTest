//
//  DDStatus.h
//  Test001
//
//  Created by wangdongdong on 16/3/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDUser.h"

@interface DDStatus : NSObject

@property (nonatomic, strong) NSNumber  *Id;
@property (nonatomic, strong) DDUser    *user;
@property (nonatomic, copy) NSString    *createdAt;
@property (nonatomic, copy) NSString    *source;
@property (nonatomic, copy) NSString    *text;

- (DDStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(DDUser *)user;
- (DDStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId;
- (DDStatus *)initWithDictionary:(NSDictionary *)dict;

+ (DDStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(DDUser *)user;
+ (DDStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId;

@end
