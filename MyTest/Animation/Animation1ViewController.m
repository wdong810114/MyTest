//
//  Animation1ViewController.m
//  Test001
//
//  Created by wangdongdong on 16/3/14.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "Animation1ViewController.h"

@interface Animation1ViewController ()

@property (nonatomic, strong) UIButton *animationButton;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation Animation1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.animationButton];
    [self.view addSubview:self.animationView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)animationButtonClicked
{
    [self doAnimation];
}

- (void)doAnimation
{
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(200, 100)];
    [path addArcWithCenter:CGPointMake(200 + 15, 100) radius:15 startAngle:M_PI endAngle:(M_PI - 0.1 / 180 * M_PI) clockwise:YES];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path closePath];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.removedOnCompletion = YES;
    animation.duration = 10.0;
    animation.delegate = self;
    
    [self.animationView.layer addAnimation:animation forKey:@"AnimationKey"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(!flag) {
        [self.animationView.layer removeAnimationForKey:@"AnimationKey"];
    }
}

- (UIButton *)animationButton
{
    if(!_animationButton) {
        _animationButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 36.0)];
        _animationButton.backgroundColor = [UIColor grayColor];
        _animationButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_animationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_animationButton setTitle:@"测试" forState:UIControlStateNormal];
        [_animationButton addTarget:self action:@selector(animationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _animationButton;
}

- (UIView *)animationView
{
    if(!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 190.0, 20.0, 20.0)];
        _animationView.backgroundColor = [UIColor redColor];
        _animationView.layer.masksToBounds = YES;
        _animationView.layer.cornerRadius = 10.0;
    }
    
    return _animationView;
}

@end
