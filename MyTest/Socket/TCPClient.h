//
//  TCPClient.h
//  MyTest
//
//  Created by wdd on 2018/9/20.
//  Copyright © 2018年 Spark. All rights reserved.
//
//  BSD Socket

#import <Foundation/Foundation.h>

@interface TCPClient : NSObject

@property (nonatomic, assign) int clientSocket;
@property (nonatomic, assign) int result;

+ (instancetype)sharedTCPClient;

// 建立连接
- (BOOL)connect:(NSString *)hostText port:(int)port;
// 发送字符串数据
- (void)sendStringToServerAndReceived:(NSString *)message;
// 断开连接
- (void)disconnect;

@end
