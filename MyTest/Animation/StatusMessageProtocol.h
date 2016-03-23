//
//  StatusMessageProtocol.h
//  MyTest
//
//  Created by wangdongdong on 16/3/23.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  STATUS_BAR_FRAME  [[UIApplication sharedApplication] statusBarFrame]

@protocol StatusMessageProtocol <NSObject>

@required
/**
 *  显示动画
 *
 *  @param seconds 显示持续时间
 */
- (void)showWithDuration:(NSTimeInterval)seconds;

/**
 *  隐藏动画(隐藏动画的时候请移除掉自己)
 *
 *  @param seconds 隐藏持续时间
 */
- (void)hideWithDuration:(NSTimeInterval)seconds;

@end
