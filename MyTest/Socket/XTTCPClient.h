//
//  XTTCPClient.h
//  MyTest
//
//  Created by wdd on 2018/9/20.
//  Copyright © 2018年 Spark. All rights reserved.
//
//  CocoaAsyncSocket

#import <Foundation/Foundation.h>

#import "GCDAsyncSocket.h"

@interface XTTCPClient : NSObject

@property (nonatomic, strong) GCDAsyncSocket *socket; // socket对象
@property (nonatomic, copy)   NSString *socketHost;   // 主机
@property (nonatomic, assign) uint16_t socketPort;    // 端口

@property (nonatomic, copy) NSString *sendData; // 向服务器发送的数据

+ (instancetype)sharedTCPClient;

- (void)socketConnectHost;
- (void)cutOffSocket;

- (void)readData:(void(^)(NSData *data))block;
- (void)writeData:(NSData *)data;

@end
