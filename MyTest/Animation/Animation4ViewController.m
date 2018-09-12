//
//  Animation4ViewController.m
//  MyTest
//
//  Created by wdd on 2018/9/12.
//  Copyright © 2018年 Spark. All rights reserved.
//

#import "Animation4ViewController.h"

@interface Animation4ViewController () <CAAnimationDelegate>

@end

@implementation Animation4ViewController
{
    CALayer *_animationLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 矩形贝塞尔曲线
    UIBezierPath *rectBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(30.0, 50.0, 100.0, 100.0)];
    [rectBezierPath moveToPoint:CGPointMake(60.0, 60.0)];
    [rectBezierPath addLineToPoint:CGPointMake(80.0, 80.0)];
    [rectBezierPath addLineToPoint:CGPointMake(60.0, 90.0)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = rectBezierPath.CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 3.0;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.0;
    shapeLayer.lineDashPattern = @[@20.0, @8.0];
    shapeLayer.miterLimit = 0.0;
    
    [self.view.layer addSublayer:shapeLayer];
    
    
    // 购物车动画
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(300.0, 120.0)];
    [bezierPath addCurveToPoint:CGPointMake(40.0, 400.0) controlPoint1:CGPointMake(240.0, 40.0) controlPoint2:CGPointMake(150.0, 60.0)];
    
    CALayer *animationLayer = [CALayer layer];
    animationLayer.backgroundColor = [UIColor redColor].CGColor;
    animationLayer.position = CGPointMake(300.0, 120.0);
    animationLayer.bounds = CGRectMake(0.0, 0.0, 30.0, 30.0);
    animationLayer.cornerRadius = 5.0;
    [self.view.layer addSublayer:animationLayer];
    _animationLayer = animationLayer;
    
    // 位置动画
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = bezierPath.CGPath;
    positionAnimation.rotationMode = kCAAnimationRotateAuto;
    
    // 大小动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.beginTime = 0.0;
    scaleAnimation.duration = 2.5;
    scaleAnimation.fromValue = @0.6;
    scaleAnimation.toValue = @0.1;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // 动画组建
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[positionAnimation, scaleAnimation];
    groupAnimation.duration = 2.5;
    groupAnimation.removedOnCompletion = YES;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.beginTime = CACurrentMediaTime() + 1.0;
    groupAnimation.delegate = self;
    
    [animationLayer addAnimation:groupAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_animationLayer removeFromSuperlayer];
}

@end
