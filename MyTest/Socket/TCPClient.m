//
//  TCPClient.m
//  MyTest
//
//  Created by wdd on 2018/9/20.
//  Copyright © 2018年 Spark. All rights reserved.
//

#import "TCPClient.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#include <netdb.h>

#define TCPHOSTADDNUM @"192.168.4.217"

@interface TCPClient ()

- (NSString *)obtainTCPIpAddressWithHost:(NSString *)hostAddr;
- (void)readStream;

@end

@implementation TCPClient

+ (instancetype)sharedTCPClient {
    
    static TCPClient *tcpClient = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tcpClient = [[self alloc] init];
    });
    
    return tcpClient;
}

/*static TCPClient *tcpClient = nil;

+ (instancetype)sharedTCPClient {
    
    @synchronized(self) {
        if(!tcpClient) {
            tcpClient = [[TCPClient alloc] init];
        }
    }
    return tcpClient;
}*/

#pragma mark - Private
- (NSString *)obtainTCPIpAddressWithHost:(NSString *)hostAddr {
    
    NSString *tcpIpStr;
    struct hostent *host_entry = gethostbyname(hostAddr.UTF8String);
    char IPStr[64] = {0};
    if(host_entry != 0) {
        sprintf(IPStr, "%d.%d.%d.%d",
                (host_entry->h_addr_list[0][0]&0x00ff),
                (host_entry->h_addr_list[0][1]&0x00ff),
                (host_entry->h_addr_list[0][2]&0x00ff),
                (host_entry->h_addr_list[0][3]&0x00ff));
        
        char *ip = inet_ntoa(*((struct in_addr *)host_entry->h_addr));
        tcpIpStr = [NSString stringWithFormat:@"%s", ip];
        NSLog(@"通过域名得到：%@", tcpIpStr);
    } else {
        tcpIpStr = TCPHOSTADDNUM;
        NSLog(@"通过IP得到：%@", tcpIpStr);
    }
    return tcpIpStr;
}

// 接收数据
- (void)readStream {
    
    /**
     第一个int:创建的socket
     void *:  接收内容的地址
     size_t:  接收内容的长度
     第二个int:接收数据的标记 0，就是阻塞式，一直等待服务器的数据
     return:  接收到的数据长度
     */
    char readBuffer[1024];
    memset(readBuffer, 0, sizeof(readBuffer));
    ssize_t receivedLen = recv(self.clientSocket, readBuffer, sizeof(readBuffer), 0);
    NSLog(@"接收的TCP数据长度 == %ld", receivedLen);

    NSString *readString = [NSString stringWithUTF8String:readBuffer];
    if(readString && ![readString isKindOfClass:[NSNull class]] && readString.length > 0) {
        // 接收到的数据 NSString 可以自己做相关的操作
        
    } else {
        // 重新连接
        
    }
}

#pragma mark - Public
- (BOOL)connect:(NSString *)hostText port:(int)port {
    
    // 1.创建Socket
    /**
     domain：协议域。AF_INET(ipv4)、AF_INET6(ipv6)。
     type：Socket类型。SOCK_STREAM(面向连接的TCP服务)/SOCK_DGRAM(无连接的UDP服务)。
     protocol：指定协议。IPPROTO_TCP、IPPROTO_UDP等，为0时，会自动选择第二个参数类型对应的默认协议。
     */
    
    self.clientSocket = - 1;
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    if(self.clientSocket > 0) {
        NSLog(@"socket 创建成功： %d", self.clientSocket);
    } else {
        NSLog(@"socket 创建失败");
        return NO;
    }
    
    // 通过域名获取Ip地址
    NSString *tcpIp = [self obtainTCPIpAddressWithHost:hostText];
    
    // 2.连接服务器
    /**
     sockfd：客户端Socket描述符。
     addr：服务端地址族、服务端IP地址、服务端端口号。
     addrlen：服务端地址字节长度。
     */
    
    struct sockaddr_in serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));
    serverAddr.sin_len = sizeof(serverAddr);
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(port);
    serverAddr.sin_addr.s_addr = inet_addr(tcpIp.UTF8String);
    self.result = connect(self.clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    
    if(self.clientSocket > 0 && self.result >= 0) {
        NSLog(@"connect 连接成功");
        return YES;
    } else {
        NSLog(@"connect 连接失败");
        [[TCPClient sharedTCPClient] disconnect];
        return NO;
    }
}

// 发送和接收字符串
- (void)sendStringToServerAndReceived:(NSString *)message {
    
    if(self.clientSocket > 0 && self.result >= 0) {
        // 不加下面的代码，如果在发送数据的途中服务器断开连接，会闪退。
        sigset_t set;
        sigemptyset(&set);
        sigaddset(&set, SIGPIPE);
        sigprocmask(SIG_BLOCK, &set, NULL);
        
        ssize_t sendLen = send(self.clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
        if(sendLen > 0) {
            NSLog(@"发送的TCP数据长度 == %ld", sendLen);
            
            [self performSelectorInBackground:@selector(readStream) withObject:nil];
        }
    } else {
        // 发送的时候如果连接失败，重新连接。
        
    }
}

// 断开连接
- (void)disconnect {
    
    if(self.clientSocket > 0) {
        close(self.clientSocket);
        self.clientSocket = -1;
    }
}

@end
