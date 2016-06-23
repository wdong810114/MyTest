//
//  ExplicitAnimation1ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/7.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "ExplicitAnimation1ViewController.h"

@interface ExplicitAnimation1ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation ExplicitAnimation1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.layerView];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0, 50.0, 100.0, 100.0);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;

    [self.layerView.layer addSublayer:self.colorLayer];
    
    [self.layerView addSubview:self.changeButton];
}

- (void)changeColor
{
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = (__bridge id)color.CGColor;
//    animation.delegate = self;
//    [self.colorLayer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = [NSArray arrayWithObjects:fn, fn, fn, nil];
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

- (UIView *)layerView
{
    if(!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0) / 2, 40.0, 200.0, 200.0)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _layerView;
}

- (UIButton *)changeButton
{
    if(!_changeButton) {
        _changeButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.layerView.bounds) - 100.0) / 2, 155.0, 100.0, 30.0)];
        _changeButton.backgroundColor = [UIColor clearColor];
        _changeButton.layer.borderWidth = 0.5;
        _changeButton.layer.borderColor = [UIColor blackColor].CGColor;
        _changeButton.layer.cornerRadius = 3.0;
        _changeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_changeButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_changeButton setTitle:@"Change Color" forState:UIControlStateNormal];
        [_changeButton addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _changeButton;
}

@end
