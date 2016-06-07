//
//  SpecialLayer3ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/6.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "SpecialLayer3ViewController.h"

#import "ScrollView.h"

@interface SpecialLayer3ViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation SpecialLayer3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ScrollView *scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(10.0, 10.0, SCREEN_WIDTH - 10.0 * 2, 200.0)];
    UIImageView *forestImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024, 768)];
    forestImageView.image = [UIImage imageNamed:@"forest.jpg"];
    [scrollView addSubview:forestImageView];
    [self.view addSubview:scrollView];
    
    [self.view addSubview:self.containerView];
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);

    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"star"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;

    emitter.emitterCells = @[cell];
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0) / 2, 250.0, 200.0, 200.0)];
        _containerView.backgroundColor = [UIColor blackColor];
    }
    
    return _containerView;
}

@end
