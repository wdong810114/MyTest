//
//  XTSocketViewController.m
//  MyTest
//
//  Created by wdd on 2018/9/20.
//  Copyright © 2018年 Spark. All rights reserved.
//

#import "XTSocketViewController.h"

#import "JSONHTTPClient.h"
#import "XTTCPClient.h"

@interface XTSocketViewController ()

@property (nonatomic, strong) UITextField *hostTextField;
@property (nonatomic, strong) UITextField *portTextField;
@property (nonatomic, strong) UIButton *connectButton;

@property (nonatomic, strong) UITextField *sendMsgTextField;
@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UILabel *receivedMsgLabel;

@property (nonatomic, strong) UILabel *statusLabel;

- (void)initSubViews;

@end

@implementation XTSocketViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initSubViews];
    
    [self requestPushService];
}

- (void)initSubViews {
    
    UITextField *hostTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 150, 50)];
    hostTextField.backgroundColor = [UIColor whiteColor];
    hostTextField.text = @"192.168.4.217";
    self.hostTextField = hostTextField;
    
    UITextField *portTextField = [[UITextField alloc] initWithFrame:CGRectMake(170, 50, 80, 50)];
    portTextField.backgroundColor = [UIColor whiteColor];
    portTextField.text = @"9912";
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

- (void)requestPushService {
    
    
}

- (void)doConnect {
    
    [XTTCPClient sharedTCPClient].socketHost = self.hostTextField.text;
    [XTTCPClient sharedTCPClient].socketPort = self.portTextField.text.intValue;
    [XTTCPClient sharedTCPClient].sendData = @"心跳包";
    
    [[XTTCPClient sharedTCPClient] cutOffSocket];
    [[XTTCPClient sharedTCPClient] socketConnectHost];
    
    [[XTTCPClient sharedTCPClient] readData:^(NSData *data) {
        self.statusLabel.text = [NSString stringWithFormat:@"接收了 %ld 字节", data.length];
        
        self.receivedMsgLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
}

- (void)doSend {
    
    NSString *sendMsg = self.sendMsgTextField.text;
    [[XTTCPClient sharedTCPClient] writeData:[sendMsg dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
