//
//  Status.h
//  MyTest
//
//  Created by wangdongdong on 16/3/21.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface Status : NSObject

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;

@end
