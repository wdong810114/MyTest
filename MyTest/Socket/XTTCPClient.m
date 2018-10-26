//
//  XTTCPClient.m
//  MyTest
//
//  Created by wdd on 2018/9/20.
//  Copyright © 2018年 Spark. All rights reserved.
//

#import "XTTCPClient.h"

#import "SocketUtils.h"

@interface XTTCPClient () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) NSTimer *connectTimer; // 心跳 计时器

@end

@implementation XTTCPClient
{
    void (^ReadBlock)(NSData *data);
}

+ (instancetype)sharedTCPClient {
    
    static XTTCPClient *tcpClient = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tcpClient = [[self alloc] init];
    });
    
    return tcpClient;
}

// socket启动连接
- (void)socketConnectHost {
    
    dispatch_queue_t queue = dispatch_queue_create("tcp.socket.queue", NULL);
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
    
    NSError *error = nil;
    [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:3 error:&error];
}

// 断开socket连接
- (void)cutOffSocket {
    
    [self.connectTimer invalidate];
    
    [self.socket disconnect];
}

// 服务器反馈回调
- (void)readData:(void(^)(NSData *data))block {
    
    ReadBlock = block;
}

- (void)writeData:(NSData *)data {
    
    NSMutableData *dd = [[NSMutableData alloc] init];
    [dd appendData:[SocketUtils bytesFromUInt32:data.length]];
    [dd appendData:data];
    [self.socket writeData:dd withTimeout:-1 tag:0];
}

// 每个心跳向服务器发送的数据
- (void)longConnectToSocket {
    
    NSData *dataStream = [self.sendData.copy dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:dataStream withTimeout:1 tag:1];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    
    NSLog(@"socket连接成功");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 方法1
        NSMutableDictionary *tlsSettings = [[NSMutableDictionary alloc] init];
        NSData *pkcs12data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cert" ofType:@"p12"]];
        CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(pkcs12data);
        CFStringRef password = CFSTR("123456");
        const void *keys[] = { kSecImportExportPassphrase };
        const void *values[] = { password };
        CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
        CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);

        OSStatus securityError = SecPKCS12Import(inPKCS12Data, options, &items);
        CFRelease(options);
        CFRelease(password);

        if(securityError == errSecSuccess)
            NSLog(@"Success opening p12 certificate.");

        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef myIdent = (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                                                      kSecImportItemIdentity);

        SecIdentityRef  certArray[1] = { myIdent };
        CFArrayRef myCerts = CFArrayCreate(NULL, (void *)certArray, 1, NULL);

        [tlsSettings setObject:(id)kCFBooleanTrue forKey:(NSString *)kCFStreamPropertySSLSettings];
        [tlsSettings setObject:(id)CFBridgingRelease(myCerts) forKey:(NSString *)kCFStreamSSLCertificates];
        [tlsSettings setObject:@"192.168.4.217" forKey:(NSString *)kCFStreamSSLPeerName];
        [tlsSettings setObject:@NO forKey:(NSString *)kCFStreamSSLValidatesCertificateChain];
        [tlsSettings setObject:@YES forKey:GCDAsyncSocketUseCFStreamForTLS];
        [self.socket startTLS:tlsSettings];
        
        
        
        
        
        // 方法2
//        NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
//
//        [settings setObject:@YES
//                     forKey:GCDAsyncSocketManuallyEvaluateTrust];
//
//        [self.socket startTLS:settings];



        
        
        
        
        
        
//        [self.socket readDataWithTimeout:-1 tag:0];
//
//        // 每隔30s像服务器发送心跳包
//        // 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
//        self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
//        [self.connectTimer fire];
    });
}

- (void)socket:(GCDAsyncSocket *)sock didReceiveTrust:(SecTrustRef)trust
completionHandler:(void (^)(BOOL shouldTrustPeer))completionHandler {
    
    //server certificate
    SecCertificateRef serverCertificate = SecTrustGetCertificateAtIndex(trust, 0);
    CFDataRef serverCertificateData = SecCertificateCopyData(serverCertificate);

    const UInt8* const serverData = CFDataGetBytePtr(serverCertificateData);
    const CFIndex serverDataSize = CFDataGetLength(serverCertificateData);
    NSData* cert1 = [NSData dataWithBytes:serverData length:(NSUInteger)serverDataSize];


    //local certificate
    NSString *localCertFilePath = [[NSBundle mainBundle] pathForResource:@"cert" ofType:@"cer"];
    NSData *localCertData = [NSData dataWithContentsOfFile:localCertFilePath];
    CFDataRef myCertData = (__bridge CFDataRef)localCertData;


    const UInt8* const localData = CFDataGetBytePtr(myCertData);
    const CFIndex localDataSize = CFDataGetLength(myCertData);
    NSData* cert2 = [NSData dataWithBytes:localData length:(NSUInteger)localDataSize];

    if (cert1 == nil || cert2 == nil) {
        NSLog(@"Certificate NULL");
        completionHandler(NO);
        return;
    }


    const BOOL equal = [cert1 isEqualToData:cert2];

    if (equal) {

        NSLog(@"Certificate match");
        completionHandler(YES);

    }else{

        NSLog(@"Certificate not match");
        completionHandler(NO);
    }
    
    

    
    
    
//    //服务器自签名证书: //openssl req -new -x509
//    //-nodes -days 365 -newkey rsa:1024 -out tv.diveinedu.com.crt -keyout
//    //tv.diveinedu.com.key
//    //Mac平台API(SecCertificateCreateWithData函数)需要der格式证书，分发到终端后需要转换一下
//    //openssl x509 -outform der -in tv.diveinedu.com.crt -out
//    //tv.diveinedu.com.der
//    NSString *certFilePath1 = [[NSBundle mainBundle] pathForResource:@"cert" ofType:@"cer"];
//    NSData *certData1 = [NSData dataWithContentsOfFile:certFilePath1];
//    OSStatus status = -1;
//    SecTrustResultType result = kSecTrustResultDeny;
//    if(certData1) {
//        SecCertificateRef cert1;
//        cert1 = SecCertificateCreateWithData(NULL, (__bridge_retained CFDataRef)certData1); // 设置证书用于验证
//        SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef)[NSArray arrayWithObject:(__bridge id)cert1]);
//        // 验证服务器证书和本地证书是否匹配
//        status = SecTrustEvaluate(trust, &result);
//    } else {
//        NSLog(@"local certificates could not be loaded");
//        completionHandler(NO);
//    }
//
//    if ((status == noErr && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified))) {
//        //成功通过验证，证书可信
//        completionHandler(YES);
//    } else {
//        CFArrayRef arrayRefTrust = SecTrustCopyProperties(trust);
//        NSLog(@"error in connection occured\n%@", arrayRefTrust);
//        completionHandler(NO);
//    }
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock {
    
    NSLog(@"SSL/TLS协商成功");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.socket readDataWithTimeout:-1 tag:0];
        
        // 每隔30s像服务器发送心跳包
        // 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
//        self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
//        [self.connectTimer fire];
    });
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    if(tag == 1) {
        NSLog(@"读取了心跳包数据: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        return;
    }
    
//    NSData *aData = [self replaceNoUtf8:data];
//    NSLog(@"读取了新的数据: %@", [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding]);
//    NSLog(@"读取了新的数据: %@", [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding]);
    
    NSData *aData1 = [data subdataWithRange:NSMakeRange(0, 4)];
    uint32_t len = [SocketUtils uint32FromBytes:aData1];
    NSLog(@"数据长度: %ld", len);
    
    NSData *aData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
    NSLog(@"读取了新的数据: %@", [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding]);

    
    dispatch_async(dispatch_get_main_queue(), ^{
        ReadBlock(data);
        
        [self.socket readDataWithTimeout:-1 tag:0];
    });
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
    NSLog(@"发送了新的数据");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
    NSLog(@"socket断开连接，error: %@", err);
    
    // 判断是不是掉线,是服务器掉线还是用户手动链接, 要是掉线就重连
    // TODO
//    [self socketConnectHost];
}

- (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    
    return md;
}


@end
