//
//  PersonInfoModel.h
//  Test001
//
//  Created by wangdongdong on 16/3/15.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "BaseModel.h"

@interface PersonInfoModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *myID;

@end
