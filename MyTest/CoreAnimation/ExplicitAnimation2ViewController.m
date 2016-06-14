//
//  ExplicitAnimation2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/8.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "ExplicitAnimation2ViewController.h"

@interface ExplicitAnimation2ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *stopButton;

@end

@implementation ExplicitAnimation2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    
    // 创建路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    // 绘制形状图层
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 2.0;
    [self.containerView.layer addSublayer:pathLayer];
    
    // 添加星星
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 30, 30);
    self.shipLayer.position = CGPointMake(0, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"star"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
    
//    // 创建关键帧动画
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 4.0;
//    animation.path = bezierPath.CGPath;
//    animation.rotationMode = kCAAnimationRotateAuto;
//    [self.shipLayer addAnimation:animation forKey:nil];
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
////    animation.keyPath = @"transform";
////    animation.duration = 2.0;
////    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    animation.keyPath = @"transform.rotation";  // 虚拟属性
//    animation.duration = 2.0;
//    animation.byValue = @(M_PI * 2);
//    [self.shipLayer addAnimation:animation forKey:nil];
    
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.stopButton];
}

- (void)start
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
}

- (void)stop
{
    [self.shipLayer removeAnimationForKey:@"rotateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 10.0, 300.0, 300.0)];
        _containerView.backgroundColor = [UIColor blackColor];
    }
    
    return _containerView;
}

- (UIButton *)startButton
{
    if(!_startButton) {
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 10.0 - 40.0, 320.0, 40.0, 30.0)];
        _startButton.backgroundColor = [UIColor blueColor];
        _startButton.layer.borderWidth = 0.5;
        _startButton.layer.borderColor = [UIColor blackColor].CGColor;
        _startButton.layer.cornerRadius = 3.0;
        _startButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_startButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startButton;
}

- (UIButton *)stopButton
{
    if(!_stopButton) {
        _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 10.0, 320.0, 40.0, 30.0)];
        _stopButton.backgroundColor = [UIColor whiteColor];
        _stopButton.layer.borderWidth = 0.5;
        _stopButton.layer.borderColor = [UIColor blackColor].CGColor;
        _stopButton.layer.cornerRadius = 3.0;
        _stopButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_stopButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_stopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _stopButton;
}

@end
