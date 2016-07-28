//
//  GCDViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/7/1.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "GCDViewController.h"
#import "GCDManager.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
}

- (void)test1
{
    // dispatch_queue_create，创建队列
    // DISPATCH_QUEUE_SERIAL，串行队列
    // DISPATCH_QUEUE_CONCURRENT，并行队列
    
    // dispatch_after，延迟提交，不是延迟运行
    // DISPATCH_TIME_NOW，表示从现在开始
    
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.queue", DISPATCH_QUEUE_SERIAL);
    
    // 立即打印一条信息
    NSLog(@"Begin add block...");
    
    // 提交一个block
    dispatch_async(queue, ^{
        // Sleep10秒
        [NSThread sleepForTimeInterval:10];
        NSLog(@"First block done...");
    });
    
    // 5秒以后提交block
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"After...");
    });
    
    [[GCDManager sharedManager] print];
    
//    Output：
//    Begin add block...
//    Singleton
//    First block done...
//    After...
}

- (void)test2
{
    // dispatch_suspend，挂起队列（并不会立即暂停正在运行的block，而是在当前block执行完成后，暂停后续的block执行）
    // dispatch_resume，恢复队列
    
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.queue", DISPATCH_QUEUE_SERIAL);
    
    // 提交第一个block，延时5秒打印。
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"After 5 seconds...");
    });
    
    // 提交第二个block，也是延时5秒打印
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"After 5 seconds again...");
    });
    
    // 延时一秒
    NSLog(@"Sleep 1 second...");
    [NSThread sleepForTimeInterval:1];
    
    // 挂起队列
    NSLog(@"Suspend...");
    dispatch_suspend(queue);
    
    // 延时10秒
    NSLog(@"Sleep 10 second...");
    [NSThread sleepForTimeInterval:10];
    
    // 恢复队列
    NSLog(@"Resume...");
    dispatch_resume(queue);
    
//    Output：
//    Sleep 1 second...
//    Suspend...
//    Sleep 10 second...
//    After 5 seconds...
//    Resume...
//    After 5 seconds again...
}

- (void)test3
{
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.queue", DISPATCH_QUEUE_SERIAL);
    
    // 运行block3次
    dispatch_apply(3, queue, ^(size_t i) {
        NSLog(@"Apply loop: %zu", i);
    });
    
    // 打印信息
    NSLog(@"After apply");
    
//    Output：
//    Apply loop: 0
//    Apply loop: 1
//    Apply loop: 2
//    After apply
}

- (void)test4
{
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4];
        
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async3");  
    });
    
//    Output：
//    dispatch_async1
//    dispatch_async2
//    dispatch_barrier_async
//    dispatch_async3
}

@end
