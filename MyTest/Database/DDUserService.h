//
//  DDUserService.h
//  Test001
//
//  Created by wangdongdong on 16/3/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDSingleton.h"
#import "DDUser.h"

@interface DDUserService : NSObject
DEFINE_SINGLETON_HEADER(DDUserService);

- (void)addUser:(DDUser *)user;
- (void)removeUser:(DDUser *)user;
- (void)removeUserByName:(NSString *)name;
- (void)modifyUser:(DDUser *)user;
- (DDUser *)getUserById:(int)Id;
- (DDUser *)getUserByName:(NSString *)name;

@end
