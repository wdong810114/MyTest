//
//  TimingAnimation1ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/14.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "TimingAnimation1ViewController.h"

@interface TimingAnimation1ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *doorLayer;

@end

@implementation TimingAnimation1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0.0, 0.0, 148.0, 225.0);
    doorLayer.position = CGPointMake(150.0 - 148.0 / 2, 225.0 / 2);
    doorLayer.anchorPoint = CGPointMake(0.0, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed: @"door"].CGImage;
    self.doorLayer = doorLayer;
    [self.containerView.layer addSublayer:doorLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    doorLayer.speed = 0.0;

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
//    animation.repeatDuration = INFINITY;
//    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGFloat x = [pan translationInView:self.view].x;
    NSLog(@"x: %0.2f", x);
    x /= 50.0;

    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;

    [pan setTranslation:CGPointZero inView:self.view];
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 80.0, 300.0, 225.0)];
        _containerView.backgroundColor = [UIColor blackColor];
    }
    
    return _containerView;
}

@end
