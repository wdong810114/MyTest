//
//  CoreAnimation3ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/5/24.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation3ViewController.h"

@interface CoreAnimation3ViewController ()

@property (nonatomic, strong) UIView *clockView;

@property (nonatomic, strong) UIView *hourHand;
@property (nonatomic, strong) UIView *minuteHand;
@property (nonatomic, strong) UIView *secondHand;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CoreAnimation3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.clockView];
    
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.8);

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}

- (void)tick
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | kCFCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;

    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
}

- (UIView *)clockView
{
    if(!_clockView) {
        _clockView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150.0) / 2, (SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - 150.0) / 2, 150.0, 150.0)];
        _clockView.backgroundColor = [UIColor whiteColor];
        
        UILabel *threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_clockView.bounds) - 30.0, (CGRectGetHeight(_clockView.bounds) - 14.0) / 2, 30.0, 14.0)];
        threeLabel.backgroundColor = [UIColor clearColor];
        threeLabel.font = [UIFont systemFontOfSize:14.0];
        threeLabel.textAlignment = NSTextAlignmentCenter;
        threeLabel.textColor = [UIColor darkGrayColor];
        threeLabel.text = @"3";
        
        UILabel *sixLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(_clockView.bounds) - 30.0) / 2, CGRectGetHeight(_clockView.bounds) - 14.0 - 10.0, 30.0, 14.0)];
        sixLabel.backgroundColor = [UIColor clearColor];
        sixLabel.font = [UIFont systemFontOfSize:14.0];
        sixLabel.textAlignment = NSTextAlignmentCenter;
        sixLabel.textColor = [UIColor darkGrayColor];
        sixLabel.text = @"6";
        
        UILabel *nineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, (CGRectGetHeight(_clockView.bounds) - 14.0) / 2, 30.0, 14.0)];
        nineLabel.backgroundColor = [UIColor clearColor];
        nineLabel.font = [UIFont systemFontOfSize:14.0];
        nineLabel.textAlignment = NSTextAlignmentCenter;
        nineLabel.textColor = [UIColor darkGrayColor];
        nineLabel.text = @"9";
        
        UILabel *twelveLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(_clockView.bounds) - 30.0) / 2, 10.0, 30.0, 14.0)];
        twelveLabel.backgroundColor = [UIColor clearColor];
        twelveLabel.font = [UIFont systemFontOfSize:14.0];
        twelveLabel.textAlignment = NSTextAlignmentCenter;
        twelveLabel.textColor = [UIColor darkGrayColor];
        twelveLabel.text = @"12";
        
        [_clockView addSubview:threeLabel];
        [_clockView addSubview:sixLabel];
        [_clockView addSubview:nineLabel];
        [_clockView addSubview:twelveLabel];
        
        self.hourHand.center = CGPointMake(CGRectGetWidth(_clockView.bounds) / 2, CGRectGetHeight(_clockView.bounds) / 2);
        self.minuteHand.center = CGPointMake(CGRectGetWidth(_clockView.bounds) / 2, CGRectGetHeight(_clockView.bounds) / 2);
        self.secondHand.center = CGPointMake(CGRectGetWidth(_clockView.bounds) / 2, CGRectGetHeight(_clockView.bounds) / 2);
        [_clockView addSubview:self.hourHand];
        [_clockView addSubview:self.minuteHand];
        [_clockView addSubview:self.secondHand];
    }
    
    return _clockView;
}

- (UIView *)hourHand
{
    if(!_hourHand) {
        _hourHand = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 6.0, 65.0)];
        _hourHand.backgroundColor = [UIColor blackColor];
    }
    
    return _hourHand;
}

- (UIView *)minuteHand
{
    if(!_minuteHand) {
        _minuteHand = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 4.0, 65.0)];
        _minuteHand.backgroundColor = [UIColor darkGrayColor];
    }
    
    return _minuteHand;
}

- (UIView *)secondHand
{
    if(!_secondHand) {
        _secondHand = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 2.0, 65.0)];
        _secondHand.backgroundColor = [UIColor redColor];
    }
    
    return _secondHand;
}

@end