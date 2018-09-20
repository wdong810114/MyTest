//
//  SocketViewController.m
//  MyTest
//
//  Created by wdd on 2018/9/18.
//  Copyright © 2018年 Spark. All rights reserved.
//

#import "SocketViewController.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <objc/runtime.h>

#import "SocketUtils.h"
#import "Models.h"

// 后面字符串是运行时获取到的C语言的类型
NSString * const TYPE_UINT8  = @"TC"; // char是1个字节，8位
NSString * const TYPE_UINT16 = @"TS"; // short是2个字节，16位
NSString * const TYPE_UINT32 = @"TI";
NSString * const TYPE_UINT64 = @"TQ";
NSString * const TYPE_STRING = @"T@\"NSString\"";
NSString * const TYPE_ARRAY  = @"T@\"NSArray\"";

@interface SocketViewController ()

@property (nonatomic, strong) UITextField *hostTextField;
@property (nonatomic, strong) UITextField *portTextField;
@property (nonatomic, strong) UIButton *connectButton;

@property (nonatomic, strong) UITextField *sendMsgTextField;
@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UILabel *receivedMsgLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, assign) int clientSocket;
@property (nonatomic, assign) BOOL isConnected;

@property (nonatomic, strong) NSMutableData *data;

- (void)initSubViews;

@end

@implementation SocketViewController

- (void)dealloc
{
    if(self.clientSocket > 0) {
        close(self.clientSocket);
        self.clientSocket = -1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)initSubViews {
    UITextField *hostTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 150, 50)];
    hostTextField.backgroundColor = [UIColor whiteColor];
    hostTextField.text = @"127.0.0.1";
    self.hostTextField = hostTextField;
    
    UITextField *portTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 50, 80, 50)];
    portTextField.backgroundColor = [UIColor whiteColor];
    portTextField.text = @"12345";
    self.portTextField = portTextField;
    
    UIButton *connectButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 50, 50, 50)];
    connectButton.backgroundColor = [UIColor redColor];
    [connectButton setTitle:@"连接" forState:UIControlStateNormal];
    [connectButton addTarget:self action:@selector(doConnect) forControlEvents:UIControlEventTouchUpInside];
    self.connectButton = connectButton;
    
    UITextField *sendMsgTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 120, 240, 50)];
    sendMsgTextField.backgroundColor = [UIColor whiteColor];
    self.sendMsgTextField = sendMsgTextField;
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 120, 50, 50)];
    sendButton.backgroundColor = [UIColor redColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton = sendButton;
    
    UILabel *receivedMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 300, 100)];
    receivedMsgLabel.backgroundColor = [UIColor whiteColor];
    receivedMsgLabel.numberOfLines = 0;
    receivedMsgLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.receivedMsgLabel = receivedMsgLabel;
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 300, 50)];
    statusLabel.backgroundColor = [UIColor whiteColor];
    self.statusLabel = statusLabel;

    [self.view addSubview:self.hostTextField];
    [self.view addSubview:self.portTextField];
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.sendMsgTextField];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.receivedMsgLabel];
    [self.view addSubview:self.statusLabel];
}

- (void)doConnect {
    if(!self.isConnected) {
        // 1.创建Socket
        /**
         domain：协议域。AF_INET(ipv4)、AF_INET6(ipv6)。
         type：指定Socket类型。SOCK_STREAM(面向连接的TCP服务)、SOCK_DGRAM(无连接的UDP服务)。
         protocol：指定协议。IPPROTO_TCP、IPPROTO_UDP等，为0时，会自动选择第二个参数类型对应的默认协议。
         */
        self.clientSocket = -1;
        self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
        
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
        serverAddr.sin_port = htons(9912);
        serverAddr.sin_addr.s_addr = inet_addr("192.168.4.217");
        
        int result = connect(self.clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
        if(result == 0) {
            [self.connectButton setTitle:@"关闭" forState:UIControlStateNormal];
            self.statusLabel.text = @"创建连接成功";
            
            self.isConnected = YES;
        } else {
            self.statusLabel.text = @"创建连接失败";
        }
    } else {
        int result = close(self.clientSocket);
        if(result == 0) {
            [self.connectButton setTitle:@"连接" forState:UIControlStateNormal];
            self.statusLabel.text = @"关闭连接成功";
            
            self.clientSocket = -1;
            self.isConnected = NO;
        } else {
            self.statusLabel.text = @"关闭连接失败";
        }
    }
}

- (void)doSend {
    if(self.isConnected) {
        NSString *sendMsg = self.sendMsgTextField.text;
        ssize_t sendLength = send(self.clientSocket, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
        if(sendLength > 0) {
            self.statusLabel.text = [NSString stringWithFormat:@"发送了 %ld 字节", sendLength];
        }
        
        char buf[1024] = {0};
        size_t len = sizeof(buf);
        ssize_t receivedLength = recv(self.clientSocket, buf, len, 0);
        if(receivedLength > 0) {
            self.statusLabel.text = [NSString stringWithFormat:@"接收了 %ld 字节", receivedLength];

            self.receivedMsgLabel.text = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
        }
    }
}

/*- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CS_1000001 *cs_one = [CS_1000001 new];
    cs_one.templateNo = @"1000001";
    cs_one.msgId = @"1";
    cs_one.mchNo = @"100001";
    
    // TODO 先将模型转换成Json格式，然后封装到CS_Connect对象中
    CS_Connect *cs_connect = [CS_Connect new];
    cs_connect.message = @"{'templateNo':'1000001','msgId':'1','mchNo':'100001'}"; // eg
    cs_connect.length = (uint32_t)cs_connect.message.length;
    
    // 创建了模型实例数据包之后，通过某种方法把它通过Socket发出去
    NSMutableData *requestData = [self requestSpliceAttribute:cs_connect];
    NSLog(@"requestData: %@", requestData);
}

//  将模型数据转换成二进制数据
- (NSMutableData *)requestSpliceAttribute:(id)obj {
    _data = nil;
    
    if(!obj) {
        return nil;
    }
    
    unsigned int propertyCount; // 成员变量个数
    objc_property_t *properties = class_copyPropertyList(NSClassFromString([NSString stringWithUTF8String:object_getClassName(obj)]), &propertyCount);
    
    NSString *type = nil;
    NSString *name = nil;
    
    for(unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        name = [NSString stringWithUTF8String:property_getName(property)];
        NSLog(@"%d.name: %@", i, name);
        type = [[[NSString stringWithUTF8String:property_getAttributes(property)] componentsSeparatedByString:@","] objectAtIndex:0]; // 获取成员变量的数据类型
        NSLog(@"%d.type: %@", i, type);
        
        id propertyValue = [obj valueForKey:[(NSString *)name substringFromIndex:0]];
        NSLog(@"%d.propertyValue: %@", i, propertyValue);
        
        NSLog(@"\n");
        
        if([type isEqualToString:TYPE_UINT8]) {
            uint8_t i = [propertyValue charValue];
            [self.data appendData:[SocketUtils byteFromUInt8:i]];
        } else if([type isEqualToString:TYPE_UINT16]){
            uint16_t i = [propertyValue shortValue];
            [self.data appendData:[SocketUtils bytesFromUInt16:i]];
        } else if([type isEqualToString:TYPE_UINT32]){
            uint32_t i = [propertyValue intValue];
            [self.data appendData:[SocketUtils bytesFromUInt32:i]];
        } else if([type isEqualToString:TYPE_UINT64]){
            uint64_t i = [propertyValue longLongValue];
            [self.data appendData:[SocketUtils bytesFromUInt64:i]];
        } else if([type isEqualToString:TYPE_STRING]){
            NSData *data = [(NSString *)propertyValue dataUsingEncoding:NSUTF8StringEncoding]; // 通过utf-8转为data
            
            // 用2个字节拼接字符串的长度拼接在字符串data之前
            [self.data appendData:[SocketUtils bytesFromUInt16:data.length]];
            // 然后拼接字符串
            [self.data appendData:data];
        } else {
            NSLog(@"requestSpliceAttribute: 未知类型");
            NSAssert(YES, @"requestSpliceAttribute: 未知类型");
        }
    }
    
    free(properties);
    
    return self.data;
}*/

- (NSMutableData *)data {
    if(!_data) {
        _data = [NSMutableData new];
    }
    
    return _data;
}

@end
