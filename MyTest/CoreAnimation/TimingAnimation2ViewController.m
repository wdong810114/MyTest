//
//  TimingAnimation2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/14.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "TimingAnimation2ViewController.h"

@interface TimingAnimation2ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UISlider *speedSlider;
@property (nonatomic, strong) UISlider *timeOffsetSlider;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *timeOffsetLabel;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CALayer *shipLayer;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation TimingAnimation2ViewController
{
    BOOL _isPlaying;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.speedSlider];
    [self.view addSubview:self.timeOffsetSlider];
    [self.view addSubview:self.speedLabel];
    [self.view addSubview:self.timeOffsetLabel];
    [self.view addSubview:self.playButton];

    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(0.0, 150.0)];
    [self.bezierPath addCurveToPoint:CGPointMake(300.0, 150.0) controlPoint1:CGPointMake(75.0, 0.0) controlPoint2:CGPointMake(225.0, 300.0)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [self.containerView.layer addSublayer:pathLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
    self.shipLayer.position = CGPointMake(0.0, 150.0);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"star"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];

    [self updateSliders];
}

- (void)updateSliders
{
    float speed = self.speedSlider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"speed: %0.2f", speed];
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"timeOffset: %0.2f", timeOffset];
}

- (void)play
{
    if(_isPlaying) {
        CFTimeInterval pausedTime = [self.shipLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.shipLayer.speed = 0.0;
        self.shipLayer.timeOffset = pausedTime;
        NSLog(@"stop timeOffset: %0.2f, beginTime: %0.2f", self.shipLayer.timeOffset, self.shipLayer.beginTime);
        
        _isPlaying = NO;
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    } else {
        if(![self.shipLayer animationForKey:@"slide"]) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"position";
            animation.timeOffset = self.timeOffsetSlider.value;
            animation.speed = self.speedSlider.value;
            animation.duration = 1.0;
            animation.path = self.bezierPath.CGPath;
            animation.rotationMode = kCAAnimationRotateAuto;
            animation.delegate = self;
            animation.removedOnCompletion = NO;
            [self.shipLayer addAnimation:animation forKey:@"slide"];
        }
        
        CFTimeInterval pausedTime = self.shipLayer.timeOffset;
        self.shipLayer.speed = 1.0;
        self.shipLayer.timeOffset = 0.0;
        self.shipLayer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self.shipLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.shipLayer.beginTime = timeSincePause;
        NSLog(@"start timeOffset: %0.2f, beginTime: %0.2f", self.shipLayer.timeOffset, self.shipLayer.beginTime);
        
        _isPlaying = YES;
        [self.playButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.shipLayer removeAnimationForKey:@"slide"];
    
    _isPlaying = NO;
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 10.0, 300.0, 300.0)];
        _containerView.backgroundColor = [UIColor blackColor];
    }
    
    return _containerView;
}

- (UISlider *)speedSlider
{
    if(!_speedSlider) {
        _speedSlider = [[UISlider alloc] initWithFrame:CGRectMake(10.0, 320.0, 180.0, 30.0)];
        _speedSlider.backgroundColor = [UIColor clearColor];
        _speedSlider.minimumValue = 0.5;
        _speedSlider.maximumValue = 2.0;
        _speedSlider.value = 1.0;
        [_speedSlider addTarget:self action:@selector(updateSliders) forControlEvents:UIControlEventValueChanged];
    }
    
    return _speedSlider;
}

- (UISlider *)timeOffsetSlider
{
    if(!_timeOffsetSlider) {
        _timeOffsetSlider = [[UISlider alloc] initWithFrame:CGRectMake(10.0, 360.0, 180.0, 30.0)];
        _timeOffsetSlider.backgroundColor = [UIColor clearColor];
        _timeOffsetSlider.minimumValue = 0.0;
        _timeOffsetSlider.maximumValue = 1.0;
        _timeOffsetSlider.value = 0.0;
        [_timeOffsetSlider addTarget:self action:@selector(updateSliders) forControlEvents:UIControlEventValueChanged];
    }
    
    return _timeOffsetSlider;
}

- (UILabel *)speedLabel
{
    if(!_speedLabel) {
        _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0, 320.0, 110.0, 30.0)];
        _speedLabel.backgroundColor = [UIColor clearColor];
        _speedLabel.font = [UIFont systemFontOfSize:14.0];
        _speedLabel.textColor = [UIColor blackColor];
        _speedLabel.text = @"speed: 1.0";
    }
    
    return _speedLabel;
}

- (UILabel *)timeOffsetLabel
{
    if(!_timeOffsetLabel) {
        _timeOffsetLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0, 360.0, 110.0, 30.0)];
        _timeOffsetLabel.backgroundColor = [UIColor clearColor];
        _timeOffsetLabel.font = [UIFont systemFontOfSize:14.0];
        _timeOffsetLabel.textColor = [UIColor blackColor];
        _timeOffsetLabel.text = @"timeOffset: 0.0";
    }
    
    return _timeOffsetLabel;
}

- (UIButton *)playButton
{
    if(!_playButton) {
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 20.0, 420.0, 40.0, 30.0)];
        _playButton.backgroundColor = [UIColor whiteColor];
        _playButton.layer.borderWidth = 0.5;
        _playButton.layer.borderColor = [UIColor blackColor].CGColor;
        _playButton.layer.cornerRadius = 3.0;
        _playButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_playButton setTitle:@"Play" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playButton;
}

@end
