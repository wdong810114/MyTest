//
//  TimingAnimation4ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/17.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "TimingAnimation4ViewController.h"

#import "AnimationMath.h"

@interface TimingAnimation4ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation TimingAnimation4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    
    UIImage *ballImage = [UIImage imageNamed:@"ball"];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    self.ballView.frame = CGRectMake(0.0, 0.0, 37.0, 37.0);
    [self.containerView addSubview:self.ballView];

    [self animate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self animate];
}

//- (void)animate
//{
//    self.ballView.center = CGPointMake(150, 32);
//
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 1.0;
//    animation.delegate = self;
//    animation.values = @[
//                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
//                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
//                         ];
//    
//    animation.timingFunctions = @[
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
//                                  ];
//    
//    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
//    self.ballView.layer.position = CGPointMake(150, 268);
//    [self.ballView.layer addAnimation:animation forKey:nil];
//}

- (void)animate
{
    self.ballView.center = CGPointMake(150, 32);

    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    CFTimeInterval duration = 1.0;

    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 0; i <= numFrames; i++) {
        float time = 1 / (float)numFrames * i;
        time = bounceEaseOut(time);
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
        NSLog(@"i: %i, time: %0.2f", i, time);
    }

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if([fromValue isKindOfClass:[NSValue class]]) {
        const char *type = [fromValue objCType];
        if(strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }

    return (time < 0.5) ? fromValue : toValue;
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 10.0, 300.0, 300.0)];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _containerView;
}

@end
