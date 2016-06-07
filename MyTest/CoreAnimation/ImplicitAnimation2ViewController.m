//
//  ImplicitAnimation2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/7.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "ImplicitAnimation2ViewController.h"

@interface ImplicitAnimation2ViewController ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation ImplicitAnimation2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if([self.colorLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

@end
