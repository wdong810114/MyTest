//
//  Models.h
//  RuntimeTestOne
//
//  Created by HEYANG on 16/6/30.
//  Copyright © 2016年 HeYang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JSONModel/JSONModel.h>

/*@interface CS_Connect : NSObject

@property (nonatomic, assign) uint32_t length;
@property (nonatomic, strong) NSString *message;

@end

@interface CS_1000001 : NSObject

@property (nonatomic, strong) NSString *templateNo; // 模板号
@property (nonatomic, strong) NSString *msgId;      // 消息id
@property (nonatomic, strong) NSString *mchNo;      // 商户号

@end*/

/**************************************************/
@interface BizData1 : JSONModel

@property (nonatomic) NSString *port; // 端口
@property (nonatomic) NSString *ip;   // 应用ip

@end

// 获取socket服务接口
// 此接口从客户端创建链接开始,服务端给客户端发送一条消息,及返回实体,后直接断开链接
@interface SC_1000000 : JSONModel

@property (nonatomic) NSString *templateNo; // 模板号
@property (nonatomic) BizData1 *bizData;    // 数据包
@property (nonatomic) NSString *timeStamp;  // 时间戳
@property (nonatomic) NSString *msgId;      // 消息id

@end
/**************************************************/


/**************************************************/
@interface BizData2 : JSONModel

@property (nonatomic) NSString *code;      // 0 成功
@property (nonatomic) NSString *initialId; // 初始化id
@property (nonatomic) NSString *msg;       // 消息

@end

// 服务端发送initId接口
// 服务端成功于客户端建立链接后,服务端回发词条消息,其中包含initId 用于登陆使用
@interface SC_1000001 : JSONModel

@property (nonatomic) NSString *templateNo; // 模板号
@property (nonatomic) BizData2 *bizData;    // 数据包
@property (nonatomic) NSString *timeStamp;  // 时间戳
@property (nonatomic) NSString *msgId;      // 消息id

@end
/**************************************************/


/**************************************************/
@interface BizData3 : JSONModel

@property (nonatomic) NSString *platform;   // 平台
@property (nonatomic) NSString *initialId;  // 初始化id
@property (nonatomic) NSString *channelKey; // 用户token
@property (nonatomic) NSString *deviceId;   // 客户端设备id
@property (nonatomic) NSString *version;    // app 版本号

@end

@interface BizData4 : JSONModel

@property (nonatomic) NSString *code; // 成功
@property (nonatomic) NSString *msg;  // success

@end

// 客户端登陆接口
// 客户端收到服务端返回的initialId后 登陆请求传入实体
@interface CS_1000002 : JSONModel

@property (nonatomic) NSString *sign;       // 签名
@property (nonatomic) NSString *templateNo; // 模板号
@property (nonatomic) BizData3 *bizData;    // 数据包
@property (nonatomic) NSString *timeStamp;  // 时间戳
@property (nonatomic) NSString *msgId;      // 消息id
@property (nonatomic) NSString *mchNo;      // 商户号

@end

@interface SC_1000002 : JSONModel

@property (nonatomic) NSString *sign;       // 签名
@property (nonatomic) NSString *templateNo; // 模板号
@property (nonatomic) BizData4 *bizData;    // 数据包
@property (nonatomic) NSString *timeStamp;  // 时间戳
@property (nonatomic) NSString *msgId;      // 消息id
@property (nonatomic) NSString *mchNo;      // 商户号

@end
/**************************************************/
