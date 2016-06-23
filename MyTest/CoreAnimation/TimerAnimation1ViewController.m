//
//  TimerAnimation1ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/20.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "TimerAnimation1ViewController.h"

#import "AnimationMath.h"

@interface TimerAnimation1ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;
//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeOffset;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval lastStep;

@end

@implementation TimerAnimation1ViewController

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

- (void)animate
{
    self.ballView.center = CGPointMake(150, 32);
    
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    
    [self.timer invalidate];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0
//                                                  target:self
//                                                selector:@selector(step:)
//                                                userInfo:nil
//                                                 repeats:YES];
    
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
}

- (void)step:(NSTimer *)step
{
//    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
    
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    
    float time = self.timeOffset / self.duration;
    time = bounceEaseOut(time);

    id position = [self interpolateFromValue:self.fromValue
                                     toValue:self.toValue
                                        time:time];

    self.ballView.center = [position CGPointValue];

    if(self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
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
