//
//  BaseViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/3/17.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"%@ didReceiveMemoryWarning", [NSString stringWithUTF8String:object_getClassName(self)]);
}

@end
