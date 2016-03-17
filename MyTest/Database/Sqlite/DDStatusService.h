//
//  DDStatusService.h
//  Test001
//
//  Created by wangdongdong on 16/3/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDSingleton.h"
#import "DDStatus.h"

@interface DDStatusService : NSObject
DEFINE_SINGLETON_HEADER(DDStatusService);

- (void)addStatus:(DDStatus *)status;
- (void)removeStatus:(DDStatus *)status;
- (void)modifyStatus:(DDStatus *)status;
- (DDStatus *)getStatusById:(int)Id;
- (NSArray *)getAllStatus;

@end
