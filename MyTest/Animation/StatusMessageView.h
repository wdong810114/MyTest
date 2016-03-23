//
//  StatusMessageView.h
//  MyTest
//
//  Created by wangdongdong on 16/3/23.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StatusMessageProtocol.h"

@interface StatusMessageView : UIView <StatusMessageProtocol>

/**
 *  创建出messageView
 *
 *  @param title 标题
 *  @param backgroundColor 背景颜色
 *
 *  @return 实例对象
 */
+ (instancetype)messageViewWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor;

@end
