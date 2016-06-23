//
//  TimingAnimation3ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/16.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "TimingAnimation3ViewController.h"

@interface TimingAnimation3ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation TimingAnimation3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.layerView];

    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    float point1[2], point2[2];
    [function getControlPointAtIndex:1 values:point1];
    [function getControlPointAtIndex:2 values:point2];
    
    CGPoint controlPoint1 = CGPointMake(point1[0], point1[1]);
    CGPoint controlPoint2 = CGPointMake(point2[0], point2[1]);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0;
    shapeLayer.path = path.CGPath;
    self.shapeLayer = shapeLayer;
    [self.layerView.layer addSublayer:shapeLayer];
    self.layerView.layer.geometryFlipped = YES;
}

- (UIView *)layerView
{
    if(!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0) / 2, 80.0, 200.0, 200.0)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _layerView;
}

@end
