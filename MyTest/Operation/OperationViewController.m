//
//  OperationViewController.m
//  MyTest
//
//  Created by wdd on 2018/2/6.
//  Copyright © 2018年 Spark. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addOperationToQueue];
}

// NSOperation是个抽象类，并不能封装任务。我们只有使用它的子类来封装任务。我们有三种方式来封装任务。
// 1、使用子类NSInvocationOperation
// 2、使用子类NSBlockOperation
// 3、定义继承自NSOperation的子类，通过实现内部相应的方法来封装任务。
- (void)addOperationToQueue
{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发操作数
//    queue.maxConcurrentOperationCount = 2;
    queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
    
    // 2. 创建操作
    // 创建NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 创建NSBlockOperation
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for(int i = 0; i < 2; ++i) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    }];
    
    // 3. 添加操作到队列中：addOperation:
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
}

- (void)run
{
    for(int i = 0; i < 2; ++i) {
        NSLog(@"2-----%@", [NSThread currentThread]);
    }
}

@end
