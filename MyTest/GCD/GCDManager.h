//
//  GCDManager.h
//  MyTest
//
//  Created by wangdongdong on 16/7/1.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDManager : NSObject

+ (GCDManager *)sharedManager;

- (void)print;

@end
