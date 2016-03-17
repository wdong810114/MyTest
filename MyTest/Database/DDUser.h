//
//  DDUser.h
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUser : NSObject

@property (nonatomic, strong) NSNumber  *Id;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *screenName;
@property (nonatomic, copy) NSString    *profileImageUrl;
@property (nonatomic, copy) NSString    *mbtype;
@property (nonatomic, copy) NSString    *city;

- (DDUser *)initWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;
- (DDUser *)initWithDictionary:(NSDictionary *)dict;

+ (DDUser *)userWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;

@end
